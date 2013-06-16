#!/usr/bin/env ruby
# -*- coding: euc-jp -*-
#---------------------------------------------------------------------------------
#
#       Version     :   0.0.1
#       Created     :   2013/6/11
#       File name   :   number-generater_spec.rb
#       Author      :   Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
#       Description :   Dummy_Plug::ScenarioWriter::NumberGenerater �� Rspec
#
#---------------------------------------------------------------------------------
#
#       Copyright (C) 2012,2013 Ichiro Kawazome
#       All rights reserved.
# 
#       Redistribution and use in source and binary forms, with or without
#       modification, are permitted provided that the following conditions
#       are met:
# 
#         1. Redistributions of source code must retain the above copyright
#            notice, this list of conditions and the following disclaimer.
# 
#         2. Redistributions in binary form must reproduce the above copyright
#            notice, this list of conditions and the following disclaimer in
#            the documentation and/or other materials provided with the
#            distribution.
# 
#       THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
#       "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
#       LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
#       A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
#       OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#       SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
#       LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#       DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
#       THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#       OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
#---------------------------------------------------------------------------------
require 'rspec'
require_relative '../../../tools/Dummy_Plug/ScenarioWriter/number-generater'

describe 'Dummy_Plug::ScenarioWriter::NumberGenerater' do

  describe 'ConstantNumberGenerater.new(1)' do
    before  { @gen = Dummy_Plug::ScenarioWriter::ConstantNumberGenerater.new(1) }
    context '����������' do
      it "@number==1" do 
        @gen.number.should == 1
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "���1���֤�" do
        10.times do
          @gen.next.should == 1
          @gen.done.should be_false
        end
      end
    end
    context '����¹Ը�˥ꥻ�å�' do
      before { 2.times{@gen.next};@gen.reset }
      it "@number==1" do 
        @gen.number.should == 1
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "���1���֤�" do
        10.times do
          @gen.next.should == 1
          @gen.done.should be_false
        end
      end
    end
  end

  describe 'ConstantNumberGenerater.new(2,3)' do
    before  { @gen = Dummy_Plug::ScenarioWriter::ConstantNumberGenerater.new(2,3) }
    context '����������' do
      it "@number==2" do 
        @gen.number.should == 2
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "3�����2���֤�4���ܰʹߤ�nil���֤�" do
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
    context '5��¹Ը�˥ꥻ�å�' do
      before { 5.times{@gen.next}; @gen.reset }
      it "@number==2" do 
        @gen.number.should == 2
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "3�����2���֤�4���ܰʹߤ�nil���֤�" do
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
  end

  describe 'SequentialNumberGenerater.new([0,1,2,3])' do
    before  { @gen = Dummy_Plug::ScenarioWriter::SequentialNumberGenerater.new([0,1,2,3]) }
    context '����������' do
      it "@seq==[0,1,2,3]" do 
        @gen.seq.should == [0,1,2,3]
      end
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3����֤��֤�" do
        @gen.curr_index.should == 0
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.curr_index.should == 0
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
      end
    end
    context '5��¹Ը�˥ꥻ�å�' do
      before { 5.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3����֤��֤�" do
        @gen.curr_index.should == 0
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.curr_index.should == 0
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
      end
    end
  end

  describe 'SequentialNumberGenerater.new([3,2,1,0],5)' do
    before  { @gen = Dummy_Plug::ScenarioWriter::SequentialNumberGenerater.new([3,2,1,0],5) }
    context '����������' do
      it "@seq==[3,2,1,0]" do 
        @gen.seq.should == [3,2,1,0]
      end
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "3,2,1,0,3���֤����θ��nil���֤�" do
        @gen.curr_index.should == 0
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 0
        @gen.next.should == 3
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
    context '5��¹Ը�˥ꥻ�å�' do
      before { 5.times{@gen.next}; @gen.reset }
      it "@seq==[3,2,1,0]" do 
        @gen.seq.should == [3,2,1,0]
      end
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "3,2,1,0,3���֤����θ��nil���֤�" do
        @gen.curr_index.should == 0
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 0
        @gen.next.should == 3
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
  end

  describe 'RandomNumberGenerater.new([4,4,4,4,4,5,5,6,7,8],100)' do
    before  { @gen = Dummy_Plug::ScenarioWriter::SequentialNumberGenerater.new([4,4,4,4,4,5,5,6,7,8],100) }
    context '����������' do
      it "@seq==[4,4,4,4,4,5,5,6,7,8]" do 
        @gen.seq.should == [4,4,4,4,4,5,5,6,7,8]
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "100�����4,5,6,7,8���椫���������֤����θ��nil���֤�" do
        100.times do
          @gen.done.should be_false
          @gen.next.should be_within(2).of(6)
        end
        10.times do
          @gen.done.should be_true
          @gen.next.should == nil
        end
      end
    end
  end

  describe 'GenericNumberGenerater.new(0...4)' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new(0...4) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,3,3,3,3,3....���֤�" do
        @gen.curr_index.should == 0
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        100.times do
          @gen.curr_index.should == 3
          @gen.next.should == 3
          @gen.done.should be_false
        end
      end
    end
    context '5��¹Ը�˥ꥻ�å�' do
      before { 5.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,3,3,3,3,3....���֤�" do
        @gen.curr_index.should == 0
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        100.times do
          @gen.curr_index.should == 3
          @gen.next.should == 3
          @gen.done.should be_false
        end
      end
    end
  end

  describe 'GenericNumberGenerater.new(0...4,6)' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new(0...4,6) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,3,3���֤����θ��nil���֤�" do
        @gen.curr_index.should == 0
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
    context '5��¹Ը�˥ꥻ�å�' do
      before { 5.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,3,3���֤����θ��nil���֤�" do
        @gen.curr_index.should == 0
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
  end

  describe 'GenericNumberGenerater.new([0,1,2,3])' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new([0,1,2,3]) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,3,3,3,3,3....���֤�" do
        @gen.curr_index.should == 0
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        100.times do
          @gen.curr_index.should == 3
          @gen.next.should == 3
          @gen.done.should be_false
        end
      end
    end
    context '3��¹Ը�˥ꥻ�å�' do
      before { 3.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,3,3,3,3,3....���֤�" do
        @gen.curr_index.should == 0
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        100.times do
          @gen.curr_index.should == 3
          @gen.next.should == 3
          @gen.done.should be_false
        end
      end
    end
  end

  describe 'GenericNumberGenerater.new([0,1,2,3],6)' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new([0,1,2,3],6) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,3,3���֤����θ��nil���֤�" do
        @gen.curr_index.should == 0
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
    context '3��¹Ը�˥ꥻ�å�' do
      before { 3.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,3,3���֤����θ��nil���֤�" do
        @gen.curr_index.should == 0
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.curr_index.should == 1
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.curr_index.should == 2
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.curr_index.should == 3
        @gen.next.should == 3
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
  end

  describe 'GenericNumberGenerater.new([[0,1,2,3]])' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new([[0,1,2,3]]) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,0,1,2,3,0,1,2,3...���֤�" do
        10.times do
          @gen.next.should == 0
          @gen.done.should be_false
          @gen.next.should == 1
          @gen.done.should be_false
          @gen.next.should == 2
          @gen.done.should be_false
          @gen.next.should == 3
          @gen.done.should be_false
        end
      end
    end
    context '9��¹Ը�˥ꥻ�å�' do
      before { 9.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,0,1,2,3,0,1,2,3...���֤�" do
        10.times do
          @gen.next.should == 0
          @gen.done.should be_false
          @gen.next.should == 1
          @gen.done.should be_false
          @gen.next.should == 2
          @gen.done.should be_false
          @gen.next.should == 3
          @gen.done.should be_false
        end
      end
    end
  end

  describe 'GenericNumberGenerater.new([[0,1,2,3]],6)' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new([[0,1,2,3]],6) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,0,1���֤����θ��nil���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
    context '9��¹Ը�˥ꥻ�å�' do
      before { 9.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,0,1���֤����θ��nil���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
  end

  describe 'GenericNumberGenerater.new([0,[1,2,3]])' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new([0,[1,2,3]]) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,1,2,3,1,2,3...���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        10.times do
          @gen.next.should == 1
          @gen.done.should be_false
          @gen.next.should == 2
          @gen.done.should be_false
          @gen.next.should == 3
          @gen.done.should be_false
        end
      end
    end
    context '9��¹Ը�˥ꥻ�å�' do
      before { 9.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,1,2,3,1,2,3...���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        10.times do
          @gen.next.should == 1
          @gen.done.should be_false
          @gen.next.should == 2
          @gen.done.should be_false
          @gen.next.should == 3
          @gen.done.should be_false
        end
      end
    end
  end

  describe 'GenericNumberGenerater.new([0,[1,2,3]],6)' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new([0,[1,2,3]],6) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,1,2���֤����θ��nil���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
    context '9��¹Ը�˥ꥻ�å�' do
      before { 9.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,1,2���֤����θ��nil���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
  end

  describe 'GenericNumberGenerater.new([[0,1,2],3])' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new([[0,1,2],3]) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,3,3,3,3...���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        10.times do
          @gen.next.should == 3
          @gen.done.should be_false
        end
      end
    end
    context '9��¹Ը�˥ꥻ�å�' do
      before { 9.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,3,3,3,3...���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        10.times do
          @gen.next.should == 3
          @gen.done.should be_false
        end
      end
    end
  end

  describe 'GenericNumberGenerater.new([[0,1,2],3],6)' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new([[0,1,2],3],6) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,3,3���֤����θ��nil���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
    context '9��¹Ը�˥ꥻ�å�' do
      before { 9.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,3,3���֤����θ��nil���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
  end

  describe 'GenericNumberGenerater.new([[0,1,2],[3,4]])' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new([[0,1,2],[3,4]]) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,4,3,4,3,4,3,4...���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        10.times do
          @gen.next.should == 3
          @gen.done.should be_false
          @gen.next.should == 4
          @gen.done.should be_false
        end
      end
    end
    context '9��¹Ը�˥ꥻ�å�' do
      before { 9.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,4,3,4,3,4,3,4...���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        10.times do
          @gen.next.should == 3
          @gen.done.should be_false
          @gen.next.should == 4
          @gen.done.should be_false
        end
      end
    end
  end

  describe 'GenericNumberGenerater.new([[0,1,2],[3,4]],8)' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new([[0,1,2],[3,4]],8) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,4,3,4,3���֤����θ��nil���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 4
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 4
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
    context '9��¹Ը�˥ꥻ�å�' do
      before { 9.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,4,3,4,3���֤����θ��nil���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 4
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 4
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
        @gen.next.should == nil
        @gen.done.should be_true
      end
    end
  end

  describe 'GenericNumberGenerater.new([SequentialNumberGenerater.new([0,1,2,3],7),[4,5,6]])' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new([Dummy_Plug::ScenarioWriter::SequentialNumberGenerater.new([0,1,2,3],7),[4,5,6]]) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,0,1,2,4,5,6,4,5,6,4,5,6...���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        10.times do
          @gen.next.should == 4
          @gen.done.should be_false
          @gen.next.should == 5
          @gen.done.should be_false
          @gen.next.should == 6
          @gen.done.should be_false
        end
      end
    end
    context '9��¹Ը�˥ꥻ�å�' do
      before { 9.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,0,1,2,4,5,6,4,5,6,4,5,6...���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        10.times do
          @gen.next.should == 4
          @gen.done.should be_false
          @gen.next.should == 5
          @gen.done.should be_false
          @gen.next.should == 6
          @gen.done.should be_false
        end
      end
    end
  end

  describe 'GenericNumberGenerater.new([GenericNumberGenerater.new([[0,1,2,3]],7),[4,5,6]])' do
    before  { @gen = Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new([Dummy_Plug::ScenarioWriter::GenericNumberGenerater.new([[0,1,2,3]],7),[4,5,6]]) }
    context '����������' do
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,0,1,2,4,5,6,4,5,6,4,5,6...���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        10.times do
          @gen.next.should == 4
          @gen.done.should be_false
          @gen.next.should == 5
          @gen.done.should be_false
          @gen.next.should == 6
          @gen.done.should be_false
        end
      end
    end
    context '9��¹Ը�˥ꥻ�å�' do
      before { 9.times{@gen.next}; @gen.reset }
      it "@curr_index==0" do 
        @gen.curr_index.should == 0
      end
      it "@done==false" do 
        @gen.done.should be_false
      end
      it "0,1,2,3,0,1,2,4,5,6,4,5,6,4,5,6...���֤�" do
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        @gen.next.should == 3
        @gen.done.should be_false
        @gen.next.should == 0
        @gen.done.should be_false
        @gen.next.should == 1
        @gen.done.should be_false
        @gen.next.should == 2
        @gen.done.should be_false
        10.times do
          @gen.next.should == 4
          @gen.done.should be_false
          @gen.next.should == 5
          @gen.done.should be_false
          @gen.next.should == 6
          @gen.done.should be_false
        end
      end
    end
  end
end
