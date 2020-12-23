<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="com.gnew.bat.dao.KeyWordStatDao">

    <!-- Beans 클래스의 객체이름(id)과 클래스이름(type)을 명시한다. -->
    <resultMap id="caApiLog" type="com.gnew.bat.model.CaApiLog">
        <!-- Beans의 멤버변수(property)이름과 대상 테이블의 컬럼(column)을 연결한다. -->
        <result property="callId"   column="call_id" />
        <result property="callDt_ymd"    column="call_dt_ymd" />
        <result property="callDt_hms"      column="call_dt_hms" />
    </resultMap>
    
    <resultMap id="caKeywordSvcnbDay" type="com.gnew.bat.model.CaKeywordSvcnbDay">
    	<id property="seq" column="seq"/>
        <result property="custnb" column="custnb" />
		<result property="statDate" column="stat_date" />
		<result property="svcnb"   column="svcnb" />
		<result property="speaker"  column="speaker" />
		<result property="keyword"  column="keyword" />
		<result property="keywordCnt"  column="keyword_cnt" />
		<result property="monNb"  column="mon_nb" />
		<result property="weekNb"  column="week_nb" />
		<result property="regUser"  column="reg_user" />
	</resultMap>
    
    <sql id="insertTable">
    	<if test="keywordType != null and keywordType != ''">
	  	<choose>
		   <when test='keywordType == "1"'>
		       <!--  인기 키워드 -->
		        <choose>
				      <when test='statiType == "1"'>
					   public.tb_ca_keyword_svcnb_day
				      </when>
				      <when test='statiType == "2"'>
				        public.tb_ca_keyword_genage_day
				      </when>
				      <when test='statiType == "3"'>
				      	public.tb_ca_keyword_area_day 
				      </when>
				      <when test='statiType == "4"'>
				    	public.tb_ca_keyword_biz_day
				      </when>
				      <otherwise>
				 		public.tb_ca_keyword_svcnb_day
				   	  </otherwise>
				 </choose>
		   </when>
		   <when test='keywordType == "2"'>
		       <!--  관심불만 키워드 -->
		        <choose>
				      <when test='statiType == "1"'>
					   public.tb_ca_user_stat_keyword_svcnb_day
				      </when>
				      <when test='statiType == "2"'>
				        public.tb_ca_user_stat_keyword_genage_day
				      </when>
				      <when test='statiType == "3"'>
				      	public.tb_ca_user_stat_keyword_area_day 
				      </when>
				      <when test='statiType == "4"'>
				    	public.tb_ca_user_stat_keyword_biz_day
				      </when>
				      <otherwise>
				 		public.tb_ca_user_stat_keyword_svcnb_day
				   	  </otherwise>
				 </choose>
		   </when>
		   <otherwise>
		 	   <!-- 콜건수 -->
		 	    <choose>
				      <when test='statiType == "1"'>
				        public.tb_ca_call_count_svcnb_data
				      </when>
				      <when test='statiType == "2"'>
				      	public.tb_ca_call_count_genage_day
				      </when>
				      <when test='statiType == "3"'>
				      	public.tb_ca_call_count_area_day 
				      </when>
				      <when test='statiType == "4"'>
       					public.tb_ca_call_count_biz_day
				      </when>
				      <otherwise>
						public.tb_ca_call_count_svcnb_data
				   	  </otherwise>
				 </choose>
		   </otherwise>
		 </choose>
	  </if>
    </sql>
    
    <sql id="insertColumn">
  	      custnb      
     	, stat_date   
		 <if test="statiType != null and statiType != ''">
		   <choose>
		      <when test='statiType == "1"'>
		        , svcnb
		      </when>
		      <when test='statiType == "2"'>
		        , custom_gender
				, custom_age 
		      </when>
		      <when test='statiType == "3"'>
				, zone_l1
 				, zone_l2
			  </when>
		      <when test='statiType == "4"'>
		    	, biz_nm       
		      </when>
		      <otherwise>
		 		, svcnb
		   	  </otherwise>
		   </choose>
		</if>
	  	<if test="keywordType != null and keywordType != ''">
		   <choose>
		      <when test='keywordType == "1"'>
		         , keyword
				 , keyword_cnt
		      </when>
		      <when test='keywordType == "2"'>
		         , keyword_type
		 	     , u_keyword  
		 	     , keyword_cnt    
		      </when>
		      <otherwise>
		      	, call_cnt  
		   	  </otherwise>
		   </choose>
		</if>
		, speaker 
		, mon_nb
		, week_nb
		, reg_user
	</sql>
	
	<sql id="selectColumn">
	  	   AL.custnb AS custnb
		 , AL.call_dt_ymd AS stat_date
		 <if test="statiType != null and statiType != ''">
		   <choose>
		      <when test='statiType == "1"'>
		        , AL.svcnb AS svcnb
		      </when>
		      <when test='statiType == "2"'>
		        , SI.custom_gender AS custom_gender
 				, SI.custom_age    AS custom_age
		      </when>
		      <when test='statiType == "3"'>
				, SI.zone_l1  AS zone_l1
 				, SI.zone_l2     AS zone_l2
			  </when>
		      <when test='statiType == "4"'>
		    	, SI.custom_bizname  AS custom_bizname       
		      </when>
		      <otherwise>
		 		, AL.svcnb AS svcnb
		   	  </otherwise>
		   </choose>
		</if>
	  	<if test="keywordType != null and keywordType != ''">
		   <choose>
		      <when test='keywordType == "1"'>
		         , COALESCE(AK.keyword,'N/A') AS keyword
			     , COUNT(AK.keyword)		AS keyword_cnt		
		      </when>
		      <when test='keywordType == "2"'>
		         , UKM.keyword_type	AS keyword_type
		 	     , COALESCE(UKM.u_keyword,'N/A') AS u_keyword  
		 	     , COUNT(UKM.u_keyword) AS keyword_cnt		
		      </when>
		      <otherwise>
		         , COUNT(AL.call_id) AS call_cnt    
		   	  </otherwise>
		   </choose>
		</if>
		, 1  AS speaker
	  	, DATE_PART('month', TO_DATE(AL.call_dt_ymd)) AS mon_nb
		, DATE_PART('week',  TO_DATE(AL.call_dt_ymd)) AS week_nb
		, #{regUser}	 		AS reg_user
	</sql>
	
	<sql id="filterKeywordSql">
	FROM (
			SELECT 
			     UK.ucid 
			   , UK.custnb
			   , (CASE WHEN UK.keyword = SK.synonym_keyword THEN SK.std_keyword 
			   		   ELSE UK.keyword  
			   		   END 
			   	 ) AS keyword
			   , UK.speaker 
			   , UK.count
			FROM (
				SELECT  A.ucid , A.keyword , A.speaker , A.count , B.custnb 
				FROM aicc_ta.tbta_aly_keyword A
				INNER JOIN public.tb_ca_api_log B 
				 ON A.ucid  = B.call_id 
				WHERE a.keyword NOT IN (
							SELECT u_keyword FROM tb_ca_user_stopword_mgt C 
							WHERE C.custnb = B.custnb)
			) UK
			LEFT OUTER JOIN (
							SELECT a.custnb , a.std_keyword , b.synonym_keyword
							FROM tb_ca_user_stdkeyword_mgt A
			  				 INNER JOIN tb_ca_user_synoymkeyword_mgt B 
							   ON  A.custnb = b.custnb 
							   AND a.seq  = b.std_keyword_seq
							WHERE 1=1
							AND a.use_yn  = 'Y'
							AND b.use_yn = 'Y'
			 ) SK
			 ON UK.custnb = SK.custnb
			 AND UK.keyword = SK.synonym_keyword 
			 WHERE 1=1
	 ) AK
	</sql>
	
	<sql id="joinTableSql">
		<choose>
	      <when test='keywordType == "1"'>
	      INNER JOIN public.tb_ca_api_log  AL 
		   ON AK.ucid =  AL.call_id  		
	      </when>
	      <when test='keywordType == "2"'>
	      INNER JOIN public.tb_ca_api_log  AL 
		    ON AK.ucid =  AL.call_id  		
	      </when>
	      <otherwise>
	       FROM public.tb_ca_api_log  AL 
		  </otherwise>
	   </choose>
	   <if test="keywordType != null and keywordType != ''">
	  	  <if test='keywordType == "2"'>
	  	  	 <!--  관심불만 키워드 join -->
		  	 INNER JOIN tb_ca_user_key_mgt  UKM
		     ON AL.custnb  = UKM.custnb 
		      AND trim(AK.keyword) = trim(UKM.u_keyword) 
		      AND ukm.use_yn  = 'Y'
		  </if>
      </if>
	 <if test="statiType != null and statiType != ''">
	 	<if test='statiType == "2" or statiType == "3" or statiType == "4"'>
	  	  <!--  성별연령,지역,업종 join -->
		  INNER JOIN tb_ca_api_subinfo SI
		   ON AL.call_id  = SI.call_id 
		 </if>
	 </if>
	 INNER JOIN public.tb_ca_biz_master  BM 
	   ON BM.custnb  = AL.custnb 
	</sql>
	
	<sql id="tailSql">
	  <if test="keywordType != null and keywordType != ''">
	  	<choose>
		   <when test='keywordType == "1"'>
		       <!--  인기 키워드 -->
		        <choose>
				      <when test='statiType == "1"'>
				        GROUP BY  AL.custnb, call_dt_ymd, al.svcnb, ak.keyword	 
						ORDER BY  AL.custnb, call_dt_ymd, al.svcnb, ak.keyword	
				      </when>
				      <when test='statiType == "2"'>
				        GROUP BY  AL.custnb, call_dt_ymd, SI.custom_gender, SI.custom_age, AK.keyword 
						ORDER BY AL.custnb, stat_date, SI.custom_gender, SI.custom_age, AK.keyword
				      </when>
				      <when test='statiType == "3"'>
				      	GROUP BY AL.custnb, call_dt_ymd, SI.zone_l1 , SI.zone_l2 , AK.keyword 
						ORDER BY AL.custnb, call_dt_ymd, SI.zone_l1 , SI.zone_l2 , AK.keyword 
				      </when>
				      <when test='statiType == "4"'>
				    	GROUP BY AL.custnb, call_dt_ymd, SI.custom_bizname, AK.keyword 
						ORDER BY AL.custnb, stat_date, SI.custom_bizname, AK.keyword
				      </when>
				      <otherwise>
				 		GROUP BY  AL.custnb, call_dt_ymd, al.svcnb, ak.keyword	 
						ORDER BY  AL.custnb, call_dt_ymd, al.svcnb, ak.keyword
				   	  </otherwise>
				 </choose>
		   </when>
		   <when test='keywordType == "2"'>
		 	    <!--  관심불만키워드 -->
			  	<choose>
				      <when test='statiType == "1"'>
				        GROUP BY AL.custnb, call_dt_ymd, al.svcnb, UKM.keyword_type, UKM.u_keyword 		 
						ORDER BY  AL.custnb, call_dt_ymd, al.svcnb, UKM.keyword_type, UKM.u_keyword
				      </when>
				      <when test='statiType == "2"'>
				      	GROUP BY AL.custnb, call_dt_ymd, SI.custom_gender, SI.custom_age,  UKM.keyword_type, UKM.u_keyword
						ORDER BY AL.custnb, stat_date, SI.custom_gender, SI.custom_age,  UKM.keyword_type, UKM.u_keyword
				      </when>
				      <when test='statiType == "3"'>
				      	GROUP BY  AL.custnb, call_dt_ymd, SI.zone_l1 , SI.zone_l2 , UKM.keyword_type, UKM.u_keyword 
						ORDER BY AL.custnb, stat_date, SI.zone_l1 , SI.zone_l2, UKM.keyword_type, UKM.u_keyword 
				      </when>
				      <when test='statiType == "4"'>
       					GROUP BY AL.custnb, call_dt_ymd, SI.custom_bizname , UKM.keyword_type, UKM.u_keyword 
						ORDER BY AL.custnb, stat_date, SI.custom_bizname , UKM.keyword_type, UKM.u_keyword
				      </when>
				      <otherwise>
						GROUP BY AL.custnb, call_dt_ymd, al.svcnb, UKM.keyword_type, UKM.u_keyword 		 
						ORDER BY  AL.custnb, call_dt_ymd, al.svcnb, UKM.keyword_type, UKM.u_keyword
				   	  </otherwise>
				 </choose>
		   </when>
		   <otherwise>
		 		<!--  콜건수 집계  -->
			  	 <choose>
				      <when test='statiType == "1"'>
				        GROUP BY  AL.custnb, AL.call_dt_ymd, AL.svcnb	 
						ORDER BY  AL.custnb, AL.call_dt_ymd, AL.svcnb
				      </when>
				      <when test='statiType == "2"'>
				      	GROUP BY  AL.custnb, AL.call_dt_ymd, SI.custom_gender, SI.custom_age
						ORDER BY  AL.custnb, AL.call_dt_ymd, SI.custom_gender, SI.custom_age
				      </when>
				      <when test='statiType == "3"'>
				      	GROUP BY  AL.custnb, AL.call_dt_ymd, SI.zone_l1, SI.zone_l2
						ORDER BY  AL.custnb, AL.call_dt_ymd, SI.zone_l1, SI.zone_l2
 				      </when>
				      <when test='statiType == "4"'>
       					GROUP BY  AL.custnb, AL.call_dt_ymd, SI.custom_bizname 
						ORDER BY  AL.custnb, AL.call_dt_ymd, SI.custom_bizname 
				      </when>
				      <otherwise>
						GROUP BY  AL.custnb, AL.call_dt_ymd, AL.svcnb	 
						ORDER BY  AL.custnb, AL.call_dt_ymd, AL.svcnb
				   	  </otherwise>
				 </choose>
		   </otherwise>
		 </choose>
	  </if>
	</sql>
	
	<delete id="deleteStatisticsDay" parameterType="java.util.Map">
       DELETE 
       FROM 
       <include refid="insertTable"/>
       WHERE 1=1
       AND stat_date = #{statDate} 
       <if test="custNb != null and custNb != ''">
		 AND custnb = #{custNb}
	   </if>
	</delete>
	
	<update id="insertStatisticsDay" parameterType="java.util.Map">
        INSERT INTO  <include refid="insertTable"/> 
        (
			<include refid="insertColumn"/>
		)SELECT
    	   	<include refid="selectColumn"/>
		<if test="keywordType != null and keywordType != ''">
		   <if test='keywordType == "1" or keywordType == "2"'> 
			<include refid="filterKeywordSql"/>
		    </if>
		</if>
		<include refid="joinTableSql"/>
		WHERE 1=1
		AND AL.call_dt_ymd = #{statDate}
		<if test="custNb != null and custNb != ''">
			AND AL.custnb = #{custNb}
		</if>
		<include refid="tailSql"/>
	</update>
	
	<insert id="insertDbLog" parameterType="java.util.Map">
		INSERT INTO tb_ca_db_log(
		   col1
		   , table_nm
		   , col3
		)VALUES(
			, #{col1}
			, #{tableNm}
			, #{col3}
		) 
	</insert>
		
</mapper>