package kr.co.anabada.item.mapper;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.hibernate.validator.constraints.ParameterScriptAssert;

import kr.co.anabada.item.entity.QnA;
import kr.co.anabada.item.entity.Question;


@Mapper
public interface QuestionMapper {
    // 문의 등록
    @Insert("INSERT INTO question (itemNo, userNo, qTitle, qContent, qDate) " +
            "VALUES (#{itemNo}, #{userNo}, #{qTitle}, #{qContent}, #{qDate})")
    void insertQ(int itemNo, int userNo, String qTitle, String qContent, LocalDateTime qDate);

    
    
    @Select("SELECT i.itemNo, q.qNo, q.qTitle, q.qContent, q.qDate " + 
            "FROM question q " + 
            "LEFT JOIN item i ON q.itemNo = i.itemNo " +
            "WHERE q.qNo = #{qNo}")  
    Question getQuestionByQNo(int qNo);

    
    @Update("UPDATE question SET qContent = #{qContent} WHERE qNo = #{qNo}")
    void updateQ(@Param("qContent") String qContent, @Param("qNo") int qNo);
    
    // 문의 삭제
    @Delete("DELETE FROM question WHERE qNo = #{qNo}")
    void deleteQ(int qNo);
    
    //내가 문의 한 목록
    @Select("SELECT i.itemName, q.qTitle, q.qContent, q.qDate, a.aContent, a.aDate " +
            "FROM question q " +
            "LEFT JOIN answer a ON q.qNo = a.qNo " +
            "LEFT JOIN item i ON q.itemNo = i.itemNo " +
            "WHERE q.userNo = #{userNo}")
    List<QnA> getQList(int userNo);  
    
    //상품별 문의 목록
    @Select("SELECT i.itemNo, q.qNo, q.qTitle, q.qContent, q.qDate, a.aContent, a.aDate, u.userNick " +
            "FROM question q " +
            "LEFT JOIN answer a ON q.qNo = a.qNo " +
            "LEFT JOIN item i ON q.itemNo = i.itemNo " +
            "LEFT JOIN user u ON q.userNo = u.userNo " +  
            "WHERE q.itemNo = #{itemNo}")
    List<QnA> getQListByItem(int itemNo);
    
    // 아이템 주인만 답변할 수 있도록 체크
    @Select("SELECT userNo FROM item WHERE itemNo = #{itemNo}")
    int getItemOwner(int itemNo);

}



    

