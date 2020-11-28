[전체 디렉백업안되서 src 폴더 백업 : _Decp_batch는 지우고..]
bin
src
conf
lib 
-프로젝트명: DECP_BATCH
-패키지명 : com.gnew.bat.~~~
-패키지구분 : 
   - conf : conf.properties load 클래스 구현 - Conf.java
             (conf.properties 위치는 메인 args로 받고 ...
              디폴트로 프로젝트 루트 폴더에 conf폴더생성해서 넣었음)
   -crypto.kisa.file : DecryptFile.java : kisa java 가이드를 사용하기 위한 구현 클래스  
                         KISA_SEED_CBC.java : kisa SEED128 CBC 암호화 가이드 파일
   -dbms : EncDecFileDbPorc.java : 파일암/복호화 배치를 위한 DB 처리 클래스
   -log : Loger.java : 로그 처리를 위한 클래스 (기본 현재 로그파일을 사용, 하루 지나면
                           날짜별로 로그 hist파일을 생성- 지우는 기능 미구현)
                           ERR, INFO, DEBUG로 구분되고, 로그 파일위치는 conf.properties에 지정)
   -main : DecryptFileBatch.java : 메인함수 구현 클래스 
             (최신파일은 수동모드 args처리 해뒀는데 이건 그전 버전인듯.)
             (args처리는 통계 배치 참고 하길..)
   -util : Util.java : 각종 편의성 함수 구현 클래스, 주로 날짜 같은거 주로 k에서 사용하던거..