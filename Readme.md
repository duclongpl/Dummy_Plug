*Dummy Plug*
============

##Notice##

*Dummy Plug* is at the moment(2012/5/3) but is not officially released yet.

##What's *Dummy Plug*##

*Dummy Plug* is a simple bus function model library written by VHDL Only.  

This models corresponds to the master and slave model of AXI4. 

*Dummy Plug* sequentially reads the scenario file that is written in a format like YAML, 
and outputs the signal pattern.

For example, when the master performs a write transaction will write the scenario, as follows.

        --- # AIX DUMMU-PLUG SAMPLE SCENARIO 1    # Start Scenario. Synchronize All Dummy Plug.
        - - MASTER                                # Name of Dummy Plug.
          - SAY: >                                # SAY Operation. Print String to STDOUT
            AIX DUMMU-PLUG SAMPLE SCENARIO 1 START
        - - MASTER                                # Name of Dummy Plug.
          - A:                                    # Address Channel Action.
            - AVALID : 0                          # AVALID <= '0'
            - WAIT   : 10                         # wait for 10 clocks.
            - ADDR   : "32'h00000010"             # ADDR   <= "00000010"
              AWRITE : 1                          # AWRITE <= '1'
              ASIZE  : "'b010"                    # ASIZE  <= 010
              AID    : 7                          # AID    <= 7
              AVALID : 1                          # AVALID <= '1'
            - WAIT   : {AVALID: 1, AREADY: 1}     # wait until AVALID = '1' and AREADY = '1'
            - AVALID : 0                          # AVALID <= '0'
            - WAIT   : {BVALID: 1, BREADY: 1}     # wait until BVALID = '1' and BREADY = '1'
          - W:                                    # Write Channel Action.
            - WVALID : 0                          # WVALID <= '0';
            - WAIT   : {AVALID: 1, AREADY: 1}     # wait until AVALID = '1' and AREADY = '1'
            - WDATA  : "32'h76543210"             # WDATA  <= "76543210"
              WSTRB  : "4'b1111"                  # WSTRB  <= "1111"
              WLAST  : 1                          # WLAST  <= '1'
              WID    : 7                          # WID    <= 7
              WVALID : 1                          # WVALID <= '1'
            - WAIT   : {WVALID: 1, WREADY: 1}     # wait until WVALID = '1' and WREADY = '1'
            - WVALID : 0                          # WVALID <= '0'
          - B:                                    # Write Responce Channel Action.
            - BVALID : 0                          # BVALID <= '0'
            - WAIT   : {AVALID: 1, AREADY: 1}     # wait until AVALID = '1' and AREADY = '1'
            - BVALID : 1                          # BVALID <= '1'
            - WAIT   : {BVALID: 1, BREADY: 1}     # wait until BVALID = '1' and BREADY = '1'
            - CHECK  :                            # 
                BRESP  : "2'b01"                  # 
                BID    : 7                        #
            - BVALID : 0                          # BVALID <= '0'
        - - SLAVE                                 # Name of Dummy Plug.
          - A:                                    # Address Channel Action.
            - AREADY : 0                          # AREADY <= '0'
            - WAIT   : {AVALID: 1, TIMEOUT: 10}   # wait until AVALID = 1 TIMEOUT 10 clock.
            - AREADY : 1                          # AREADY <= '1'
            - WAIT   : {AVALID: 1, AREADY: 1}     # wait until AVALID = 1 and AREADY = 1
            - CHECK  :                            # 
                ADDR   : "32'h00000010"           # 
                AWRITE : 1                        #
                ASIZE  : "'b010"                  #
                AID    : 7                        #
            - AREADY : 0                          # AREADY <= '0'
          - W:                                    # Write Channel Action.
            - WREADY : 0                          # WREADY <= '0'
            - WAIT   : {AVALID: 1, AREADY: 1}     # wait until AVALID = 1 and AREADY = 1
            - WREADY : 1                          # WREADY <= '1'
            - WAIT   : {WVALID: 1, WREADY: 1}     # wait until WVALID = 1 and WREADY = 1 
            - CHECK  :                            # 
                WDATA  : "32'h76543210"           # 
                WSTRB  : "4'b1111"                #
                WLAST  : 1                        #
                WID    : 7                        #
            - WREADY : 0                          # WREADY <= '0'
          - B:                                    # Write Responce Channel Action.
            - BVALID : 0                          # BVALID <= '0'
            - WAIT   : {WVALID: 1, WREADY: 1}     # wait until WVALID = '1' and WREADY = '1'
            - BVALID : 1                          # BVALID <= '1'
              BRESP  : "2'b01"                    # BRESP  <= "01"
              BID    : 7                          # BID    <= 7
            - WAIT   : {BVALID: 1, BREADY: 1}     # wait until BVALID = '1' and BREADY = '1'
            - BVALID : 0                          # BVALID <= '1'
              BRESP  : "2'b00"                    # BRESP  <= "00"
        ---                                       # Synchronize All Dummy Plug.
        - - MASTER                                # Name of Dummy Plug.
          - SAY: >                                # SAY Operation. Print String to STDOUT
            AIX DUMMU-PLUG SAMPLE SCENARIO 1 DONE
        ---

##Trial##

*Dummy Plug* is checking operation by GHDL.  
When "cd sim/ghdl" and "make",  library and test bench is compiled and it is begun to run.

##License##

2-clause BSD license

