-----------------------------------------------------------------------------------
--!     @file    axi4_models.vhd
--!     @brief   AXI4 Dummy Plug Component Package.
--!     @version 1.0.0
--!     @date    2012/6/2
--!     @author  Ichiro Kawazome <ichiro_k@ca2.so-net.ne.jp>
-----------------------------------------------------------------------------------
--
--      Copyright (C) 2012 Ichiro Kawazome
--      All rights reserved.
--
--      Redistribution and use in source and binary forms, with or without
--      modification, are permitted provided that the following conditions
--      are met:
--
--        1. Redistributions of source code must retain the above copyright
--           notice, this list of conditions and the following disclaimer.
--
--        2. Redistributions in binary form must reproduce the above copyright
--           notice, this list of conditions and the following disclaimer in
--           the documentation and/or other materials provided with the
--           distribution.
--
--      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
--      A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
--      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
--      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
--      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
--      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
--      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
--      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
--      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--
-----------------------------------------------------------------------------------
library ieee;
use     ieee.std_logic_1164.all;
library DUMMY_PLUG;
use     DUMMY_PLUG.AXI4_TYPES.all;
use     DUMMY_PLUG.CORE.REPORT_STATUS_TYPE;
use     DUMMY_PLUG.SYNC.SYNC_SIG_VECTOR;
use     DUMMY_PLUG.SYNC.SYNC_PLUG_NUM_TYPE;
-----------------------------------------------------------------------------------
--! @brief AXI4 Dummy Plug の各種モデルのコンポーネント宣言をまとめたパッケージ.
-----------------------------------------------------------------------------------
package AXI4_MODELS is

-----------------------------------------------------------------------------------
--! @brief   AXI4 Master Dummy Plug Player.
-----------------------------------------------------------------------------------
component AXI4_MASTER_PLAYER is
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        SCENARIO_FILE   : --! @brief シナリオファイルの名前.
                          STRING;
        NAME            : --! @brief 固有名詞.
                          STRING;
        READ_ENABLE     : --! @brief リードトランザクションの可/不可を指定する.
                          boolean   := TRUE;
        WRITE_ENABLE    : --! @brief ライトトランザクションの可/不可を指定する.
                          boolean   := TRUE;
        OUTPUT_DELAY    : --! @brief 出力信号遅延時間
                          time    := 0 ns;
        WIDTH           : --! @brief AXI4 チャネルの可変長信号のビット幅.
                          AXI4_SIGNAL_WIDTH_TYPE;
        SYNC_PLUG_NUM   : --! @brief シンクロ用信号のプラグ番号.
                          SYNC_PLUG_NUM_TYPE := 1;
        SYNC_WIDTH      : --! @brief シンクロ用信号の本数.
                          integer :=  1;
        GPI_WIDTH       : --! @brief GPI(General Purpose Input)信号のビット幅.
                          integer := 8;
        GPO_WIDTH       : --! @brief GPO(General Purpose Output)信号のビット幅.
                          integer := 8;
        FINISH_ABORT    : --! @brief FINISH コマンド実行時にシミュレーションを
                          --!        アボートするかどうかを指定するフラグ.
                          boolean := true
    );
    -------------------------------------------------------------------------------
    -- 入出力ポートの定義.
    -------------------------------------------------------------------------------
    port(
        --------------------------------------------------------------------------
        -- グローバルシグナル.
        --------------------------------------------------------------------------
        ACLK            : in    std_logic;
        ARESETn         : in    std_logic;
        --------------------------------------------------------------------------
        -- リードアドレスチャネルシグナル.
        --------------------------------------------------------------------------
        ARADDR          : inout std_logic_vector(WIDTH.ARADDR -1 downto 0);
        ARLEN           : inout AXI4_ALEN_TYPE;
        ARSIZE          : inout AXI4_ASIZE_TYPE;
        ARBURST         : inout AXI4_ABURST_TYPE;
        ARLOCK          : inout AXI4_ALOCK_TYPE;
        ARCACHE         : inout AXI4_ACACHE_TYPE;
        ARPROT          : inout AXI4_APROT_TYPE;
        ARQOS           : inout AXI4_AQOS_TYPE;
        ARREGION        : inout AXI4_AREGION_TYPE;
        ARUSER          : inout std_logic_vector(WIDTH.ARUSER -1 downto 0);
        ARID            : inout std_logic_vector(WIDTH.ID     -1 downto 0);
        ARVALID         : inout std_logic;
        ARREADY         : in    std_logic;
        --------------------------------------------------------------------------
        -- リードチャネルシグナル.
        --------------------------------------------------------------------------
        RLAST           : in    std_logic;
        RDATA           : in    std_logic_vector(WIDTH.RDATA  -1 downto 0);
        RRESP           : in    AXI4_RESP_TYPE;
        RUSER           : in    std_logic_vector(WIDTH.RUSER  -1 downto 0);
        RID             : in    std_logic_vector(WIDTH.ID     -1 downto 0);
        RVALID          : in    std_logic;
        RREADY          : inout std_logic;
        --------------------------------------------------------------------------
        -- ライトアドレスチャネルシグナル.
        --------------------------------------------------------------------------
        AWADDR          : inout std_logic_vector(WIDTH.AWADDR -1 downto 0);
        AWLEN           : inout AXI4_ALEN_TYPE;
        AWSIZE          : inout AXI4_ASIZE_TYPE;
        AWBURST         : inout AXI4_ABURST_TYPE;
        AWLOCK          : inout AXI4_ALOCK_TYPE;
        AWCACHE         : inout AXI4_ACACHE_TYPE;
        AWPROT          : inout AXI4_APROT_TYPE;
        AWQOS           : inout AXI4_AQOS_TYPE;
        AWREGION        : inout AXI4_AREGION_TYPE;
        AWUSER          : inout std_logic_vector(WIDTH.AWUSER -1 downto 0);
        AWID            : inout std_logic_vector(WIDTH.ID     -1 downto 0);
        AWVALID         : inout std_logic;
        AWREADY         : in    std_logic;
        --------------------------------------------------------------------------
        -- ライトチャネルシグナル.
        --------------------------------------------------------------------------
        WLAST           : inout std_logic;
        WDATA           : inout std_logic_vector(WIDTH.WDATA  -1 downto 0);
        WSTRB           : inout std_logic_vector(WIDTH.WDATA/8-1 downto 0);
        WUSER           : inout std_logic_vector(WIDTH.WUSER  -1 downto 0);
        WID             : inout std_logic_vector(WIDTH.ID     -1 downto 0);
        WVALID          : inout std_logic;
        WREADY          : in    std_logic;
        --------------------------------------------------------------------------
        -- ライト応答チャネルシグナル.
        --------------------------------------------------------------------------
        BRESP           : in    AXI4_RESP_TYPE;
        BUSER           : in    std_logic_vector(WIDTH.BUSER  -1 downto 0);
        BID             : in    std_logic_vector(WIDTH.ID     -1 downto 0);
        BVALID          : in    std_logic;
        BREADY          : inout std_logic;
        --------------------------------------------------------------------------
        -- シンクロ用信号
        --------------------------------------------------------------------------
        SYNC            : inout SYNC_SIG_VECTOR (SYNC_WIDTH   -1 downto 0);
        --------------------------------------------------------------------------
        -- GPIO
        --------------------------------------------------------------------------
        GPI             : in    std_logic_vector(GPI_WIDTH    -1 downto 0) := (others => '0');
        GPO             : out   std_logic_vector(GPO_WIDTH    -1 downto 0);
        --------------------------------------------------------------------------
        -- 各種状態出力.
        --------------------------------------------------------------------------
        REPORT_STATUS   : out   REPORT_STATUS_TYPE;
        FINISH          : out   std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief   AXI4 Slave Dummy Plug Player.
-----------------------------------------------------------------------------------
component AXI4_SLAVE_PLAYER is
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        SCENARIO_FILE   : --! @brief シナリオファイルの名前.
                          STRING;
        NAME            : --! @brief 固有名詞.
                          STRING;
        READ_ENABLE     : --! @brief リードトランザクションの可/不可を指定する.
                          boolean   := TRUE;
        WRITE_ENABLE    : --! @brief ライトトランザクションの可/不可を指定する.
                          boolean   := TRUE;
        OUTPUT_DELAY    : --! @brief 出力信号遅延時間
                          time    := 0 ns;
        WIDTH           : --! @brief AXI4 チャネルの可変長信号のビット幅.
                          AXI4_SIGNAL_WIDTH_TYPE;
        SYNC_PLUG_NUM   : --! @brief シンクロ用信号のプラグ番号.
                          SYNC_PLUG_NUM_TYPE := 1;
        SYNC_WIDTH      : --! @brief シンクロ用信号の本数.
                          integer :=  1;
        GPI_WIDTH       : --! @brief GPI(General Purpose Input)信号のビット幅.
                          integer := 8;
        GPO_WIDTH       : --! @brief GPO(General Purpose Output)信号のビット幅.
                          integer := 8;
        FINISH_ABORT    : --! @brief FINISH コマンド実行時にシミュレーションを
                          --!        アボートするかどうかを指定するフラグ.
                          boolean := true
    );
    -------------------------------------------------------------------------------
    -- 入出力ポートの定義.
    -------------------------------------------------------------------------------
    port(
        --------------------------------------------------------------------------
        -- グローバルシグナル.
        --------------------------------------------------------------------------
        ACLK            : in    std_logic;
        ARESETn         : in    std_logic;
        --------------------------------------------------------------------------
        -- リードアドレスチャネルシグナル.
        --------------------------------------------------------------------------
        ARADDR          : in    std_logic_vector(WIDTH.ARADDR -1 downto 0);
        ARLEN           : in    AXI4_ALEN_TYPE;
        ARSIZE          : in    AXI4_ASIZE_TYPE;
        ARBURST         : in    AXI4_ABURST_TYPE;
        ARLOCK          : in    AXI4_ALOCK_TYPE;
        ARCACHE         : in    AXI4_ACACHE_TYPE;
        ARPROT          : in    AXI4_APROT_TYPE;
        ARQOS           : in    AXI4_AQOS_TYPE;
        ARREGION        : in    AXI4_AREGION_TYPE;
        ARUSER          : in    std_logic_vector(WIDTH.ARUSER -1 downto 0);
        ARID            : in    std_logic_vector(WIDTH.ID     -1 downto 0);
        ARVALID         : in    std_logic;
        ARREADY         : inout std_logic;
        --------------------------------------------------------------------------
        -- リードチャネルシグナル.
        --------------------------------------------------------------------------
        RVALID          : inout std_logic;
        RLAST           : inout std_logic;
        RDATA           : inout std_logic_vector(WIDTH.RDATA  -1 downto 0);
        RRESP           : inout AXI4_RESP_TYPE;
        RUSER           : inout std_logic_vector(WIDTH.RUSER  -1 downto 0);
        RID             : inout std_logic_vector(WIDTH.ID     -1 downto 0);
        RREADY          : in    std_logic;
        --------------------------------------------------------------------------
        -- ライトアドレスチャネルシグナル.
        --------------------------------------------------------------------------
        AWADDR          : in    std_logic_vector(WIDTH.AWADDR -1 downto 0);
        AWLEN           : in    AXI4_ALEN_TYPE;
        AWSIZE          : in    AXI4_ASIZE_TYPE;
        AWBURST         : in    AXI4_ABURST_TYPE;
        AWLOCK          : in    AXI4_ALOCK_TYPE;
        AWCACHE         : in    AXI4_ACACHE_TYPE;
        AWPROT          : in    AXI4_APROT_TYPE;
        AWQOS           : in    AXI4_AQOS_TYPE;
        AWREGION        : in    AXI4_AREGION_TYPE;
        AWUSER          : in    std_logic_vector(WIDTH.AWUSER -1 downto 0);
        AWID            : in    std_logic_vector(WIDTH.ID     -1 downto 0);
        AWVALID         : in    std_logic;
        AWREADY         : inout std_logic;
        --------------------------------------------------------------------------
        -- ライトチャネルシグナル.
        --------------------------------------------------------------------------
        WVALID          : in    std_logic;
        WLAST           : in    std_logic;
        WDATA           : in    std_logic_vector(WIDTH.WDATA  -1 downto 0);
        WSTRB           : in    std_logic_vector(WIDTH.WDATA/8-1 downto 0);
        WUSER           : in    std_logic_vector(WIDTH.WUSER  -1 downto 0);
        WID             : in    std_logic_vector(WIDTH.ID     -1 downto 0);
        WREADY          : inout std_logic;
        --------------------------------------------------------------------------
        -- ライト応答チャネルシグナル.
        --------------------------------------------------------------------------
        BVALID          : inout std_logic;
        BUSER           : inout std_logic_vector(WIDTH.BUSER  -1 downto 0);
        BRESP           : inout AXI4_RESP_TYPE;
        BID             : inout std_logic_vector(WIDTH.ID     -1 downto 0);
        BREADY          : in    std_logic;
        --------------------------------------------------------------------------
        -- シンクロ用信号
        --------------------------------------------------------------------------
        SYNC            : inout SYNC_SIG_VECTOR (SYNC_WIDTH   -1 downto 0);
        --------------------------------------------------------------------------
        -- GPIO
        --------------------------------------------------------------------------
        GPI             : in    std_logic_vector(GPI_WIDTH    -1 downto 0) := (others => '0');
        GPO             : out   std_logic_vector(GPO_WIDTH    -1 downto 0);
        --------------------------------------------------------------------------
        -- 各種状態出力.
        --------------------------------------------------------------------------
        REPORT_STATUS   : out   REPORT_STATUS_TYPE;
        FINISH          : out   std_logic
    );
end component;
-----------------------------------------------------------------------------------
--! @brief   AXI4_SIGNAL_PRINTER :
-----------------------------------------------------------------------------------
component AXI4_SIGNAL_PRINTER is
    -------------------------------------------------------------------------------
    -- ジェネリック変数.
    -------------------------------------------------------------------------------
    generic (
        NAME            : --! @brief 固有名詞.
                          STRING;
        TAG             : --! @brief
                          STRING;
        READ_ENABLE     : --! @brief リードチャネルを出力するか否かを指定する.
                          boolean   := TRUE;
        WRITE_ENABLE    : --! @brief ライトチャネルを出力するか否かを指定する.
                          boolean   := TRUE;
        TAG_WIDTH       : --! @brief タグを出力する際の文字幅.
                          --!      * TAG_WIDTH>0 =>  TAG_WIDTH幅の右詰.
                          --!      * TAG_WIDTH<0 => -TAG_WIDTH幅の左詰.
                          --!      * TAG_WIDTH=0 => 出力しない.
                          integer := 13;
        TIME_WIDTH      : --! @brief 時間を出力する際の文字幅.
                          --!      * TIME_WIDTH>0 =>  TAG_WIDTH幅の右詰.
                          --!      * TIME_WIDTH<0 => -TAG_WIDTH幅の左詰.
                          --!      * TIEM_WIDTH=0 => 出力しない.
                          integer := 13;
        WIDTH           : --! @brief AXI4 チャネルの可変長信号のビット幅.
                          AXI4_SIGNAL_WIDTH_TYPE
    );
    -------------------------------------------------------------------------------
    -- 入出力ポートの定義.
    -------------------------------------------------------------------------------
    port(
        --------------------------------------------------------------------------
        -- グローバルシグナル.
        --------------------------------------------------------------------------
        ACLK            : in    std_logic;
        ARESETn         : in    std_logic;
        --------------------------------------------------------------------------
        -- リードアドレスチャネルシグナル.
        --------------------------------------------------------------------------
        ARADDR          : in    std_logic_vector(WIDTH.ARADDR -1 downto 0);
        ARLEN           : in    AXI4_ALEN_TYPE;
        ARSIZE          : in    AXI4_ASIZE_TYPE;
        ARBURST         : in    AXI4_ABURST_TYPE;
        ARLOCK          : in    AXI4_ALOCK_TYPE;
        ARCACHE         : in    AXI4_ACACHE_TYPE;
        ARPROT          : in    AXI4_APROT_TYPE;
        ARQOS           : in    AXI4_AQOS_TYPE;
        ARREGION        : in    AXI4_AREGION_TYPE;
        ARUSER          : in    std_logic_vector(WIDTH.ARUSER -1 downto 0);
        ARID            : in    std_logic_vector(WIDTH.ID     -1 downto 0);
        ARVALID         : in    std_logic;
        ARREADY         : in    std_logic;
        --------------------------------------------------------------------------
        -- リードチャネルシグナル.
        --------------------------------------------------------------------------
        RLAST           : in    std_logic;
        RDATA           : in    std_logic_vector(WIDTH.RDATA  -1 downto 0);
        RRESP           : in    AXI4_RESP_TYPE;
        RUSER           : in    std_logic_vector(WIDTH.RUSER  -1 downto 0);
        RID             : in    std_logic_vector(WIDTH.ID     -1 downto 0);
        RVALID          : in    std_logic;
        RREADY          : in    std_logic;
        --------------------------------------------------------------------------
        -- ライトアドレスチャネルシグナル.
        --------------------------------------------------------------------------
        AWADDR          : in    std_logic_vector(WIDTH.AWADDR -1 downto 0);
        AWLEN           : in    AXI4_ALEN_TYPE;
        AWSIZE          : in    AXI4_ASIZE_TYPE;
        AWBURST         : in    AXI4_ABURST_TYPE;
        AWLOCK          : in    AXI4_ALOCK_TYPE;
        AWCACHE         : in    AXI4_ACACHE_TYPE;
        AWPROT          : in    AXI4_APROT_TYPE;
        AWQOS           : in    AXI4_AQOS_TYPE;
        AWREGION        : in    AXI4_AREGION_TYPE;
        AWUSER          : in    std_logic_vector(WIDTH.AWUSER -1 downto 0);
        AWID            : in    std_logic_vector(WIDTH.ID     -1 downto 0);
        AWVALID         : in    std_logic;
        AWREADY         : in    std_logic;
        --------------------------------------------------------------------------
        -- ライトデータチャネルシグナル.
        --------------------------------------------------------------------------
        WLAST           : in    std_logic;
        WDATA           : in    std_logic_vector(WIDTH.WDATA  -1 downto 0);
        WSTRB           : in    std_logic_vector(WIDTH.WDATA/8-1 downto 0);
        WUSER           : in    std_logic_vector(WIDTH.WUSER  -1 downto 0);
        WID             : in    std_logic_vector(WIDTH.ID     -1 downto 0);
        WVALID          : in    std_logic;
        WREADY          : in    std_logic;
        --------------------------------------------------------------------------
        -- ライト応答チャネルシグナル.
        --------------------------------------------------------------------------
        BRESP           : in    AXI4_RESP_TYPE;
        BUSER           : in    std_logic_vector(WIDTH.BUSER  -1 downto 0);
        BID             : in    std_logic_vector(WIDTH.ID     -1 downto 0);
        BVALID          : in    std_logic;
        BREADY          : in    std_logic
    );
end component;
end package;
