[전체 디렉백업안되서 src 폴더 백업 : _DB_batch는 지우고..]
bin
src
conf
lib
 !!!  중요 : - gnew_query에 메타 쿼리에 vo, 일반파람, 컬럼정보는 메타 뽑는 쿼리 사용가능
      - lombock 사용안될때 등 코드 작성에 좀 도움이 될듯..postgre 버전) 
-프로젝트명: DB_BATCH
-패키지명 : com.gnew.bat.~~~
-패키지구분 : 
   - conf : Conf.java : conf.properties load 클래스 구현 - 
             (conf.properties 위치는 메인 args로 받고 ...
              디폴트로 프로젝트 루트 폴더에 conf폴더생성해서 넣었음)
	mybatisConfig.xml : 배치에 mybatic올려는데 mybatis설정 파일(DB접속정보, xml맵핑등)
   -controller : BatchMain.java 메인함수 구현 클래스 (args처리 포함)
   -dao : KeyWordStatDao : 키워드 통계 처리 Dao
            CaApiLogDao : 초기 테스트용 dao - vo만들고 여기에 간단한 select 만들어서 테스트 진행
  -mapper : *.xml : dao에서 사용하는 sql 쿼리 저장
  -model : *.java : 통계 테이블 별로 vo  만들어서 사용하려 했으나 select insert사용하면서 
                필요없어져서 사용안함. vo없이 사용하기도 하니까.. 
  -mybatis : MybatisConnectonFactory.java : mybatis사용을 위한 구현 클래스
                (그냥 공식 가이드 그대로 참고 했음.. 별 구현 없음)
  -service : KeywordStatistics.java : 키워드 통계 인터페이스 클래스 
               KeywordStatisticsImpl.java : 키워드 통계 실 구현 클래스 
              (그냥 요새 spring mvc패턴따라서 인터페이스와 구현 클래스 나눔)
  -util : KISA_SEED_CBC.java : kisa SEED128 CBC 암호화 가이드 파일
          TextEnDecryptor.java : kisa java 가이드를 사용하여 단순한 text 암/복호화 구현 클래스  
          Loger.java : 로그 처리를 위한 클래스 (기본 현재 로그파일을 사용, 하루 지나면
                           날짜별로 로그 hist파일을 생성- 지우는 기능 미구현)
                           ERR, INFO, DEBUG로 구분되고, 로그 파일위치는 conf.properties에 지정)
           Util.java : 각종 편의성 함수 구현 클래스, 주로 날짜 같은거 주로 k에서 사용하던거..