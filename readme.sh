[ DB Sync 테이블 모니터링 - Active 토큰을 주고 받으면 각 두대의 머신을 대상으로 
active-standby 모드 실행 유지 ]
: db 쿼리리턴 - timestamp와 atvice token은 모두 db 테이블상에서 처리 되는 개념
 :
   RUN : 모니터링 중인 상대프로세스의 TIMESTAMP가 확인 되지 않아(conf-detectChkMin설정) 
           수행 런처가 자신의 (java 프로세스?) 프로세스를 기동 해야 할 상태
           이 경우 모니터링 중인 상태 런처로 부터 active토큰을 가져오고 정해진 주기(conf-detectChkMin설정)데로
           TIMESTAMP 처리 한다. 
   STANDBY : 모니터링 중인 상대프로세스가 정상 동작중인 상태(conf-detectChkMin설정데로 timestamp 확인)
   ACITIVATED : Active token을 가진 런처가 DB Sync 프로세스 모니터링 시 리턴 값
                   - 이경우 해당 launcher는 업무 배치 프로세스를 실행 하면 됨.
                     (자신이 구동중일 경우 상태방 상태는 확인 무의미..자기 할일만(배치수행) 하면됨)
                     (반대되는 대상의 상태를 모니터링 해야하고-모니터링 상대가 죽으면 자신의 프로세스 구동 )

[실행 쉘 설명] 
  1. ./decp.sh {start | stop}
    : 프로세스 실행/중지 기동 쉘 (단일수행-바로가기역활)
       start : decp_start.sh pid 체크 후 실행중이지 않을 경우 실행 : 
       stop - decp_stop.sh 실행 

	2. ./bin/decp_start.sh 
	: luauncher 프로세스 실행- conf에 설정된 binPath의 runFile을 실행 
	  무한루프로 java process(launcher)를 체크하여 종료 시 재 구동 
	 (구동: conf 종료인터럽트 체크인 상대로 변경 후 해당 쉘(binPath/runfile) 또는 nohup java를 실행 한다. 
	  (ex : ./bin/startLauncher.sh 실행)
	=> nohup  java 배치java프로세스(launcher)
	
	3. ./bin/decp_stop.sh 
	: launcher 프로세스 종료 하는 쉘 
	  conf.properties의 종료값(launcherExitChk)을 1로 수정 하여 (체크 아웃)
	  (java 배치) 프로세스가 해당 값을 참조하여 종료 할 수 있도록 한다.
	: (java 배치 프로세스-launcher는) conf.properties의 종료값(launcherExitChk)을 확인하고 종료
	
  3.  java 배치 프로세스-launcher
    : launcher 프로세스에서 이중화 체크 해서 Active-Standby 모드로 업무배치 프로세스 startDecryptoFile.sh 실행
     : conf-sleepSec을 주기로 무한루프 실행 (종료값으로 설정된 경우 루프탈출 후 종료)
      launcher java 프로세스는 스켸쥴링 등을 관리 하고 실제 배치 업무 프로세는 단독 실행만 하면 됨.
      스케쥴링 런처와 실업무 프로세스 분리 
      => launcher java프로세스에서 업무 자바 프로세스 실행 쉘을 호출 하는  형태로 구현 
          (바로 java 실행하는 형태로 수정해도 좋을듯..그럼 sh파일 하나가 줄겠지..똑같이 ProcessBuilder이용)
       (launcher는 conf.properties의 종료값(launcherExitChk)이 1인경우 루프 탈출 하고 
        launcher 프로세스를 종료 한다. - 이때 decp_start.sh이 구동중이라면 launcher프로세스는 재실행됨)
     
  4. startDecryptoFile.sh : 
     : 업무 배치 프로세스 실행 쉘
       복호화 프로세스 DecryptFileBatch 실행 - 메인 복호화 실행
       ( DecryptFileBatch 프로세스는 이중화 및 실행주기를 등을 관여하지 않고 1회 수행 후 종료)

=> main_args_01 : 복호화 모듈(무한루프 없이 단독 실행종료), launcher모듈 독립 : '
                      :decp_start.sh가 startLauncher.sh실행 LauncherBatch java가  startDecryptoFile.sh실행
                      (DecryptBatch java 실행)

   main_areg_02 : 복호화 모듈(무한루프-기존 launcher처럼..) , launcher 수정 없고 사용안함
      : decp_start.sh : runFile 을 기존 startLauncher.sh에서 => startDecryptoFile.sh 로 변경
                         conf.properties의 launcherFile에서 => decpBatFile로변경
      : decp_stop.sh : PID 체크 부분을 'LauncherBatch'에서 DecryuptBatch 로..
      :decp_start.sh가 startDecryptoFile.sh실행 -> startDecryptoFile.sh가 DecryptBatch java 실행(무한루프 sleep)
            
myBackUp은 일단 - main_agrs_01 : 별개모드, feature-01  : cron모드를 backup받자..
