package kr.co.anabada.item.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.anabada.item.entity.Answer;
import kr.co.anabada.item.entity.QnA;

@Mapper
public interface AnswerMapper {
    @Insert("INSERT INTO answer (qNo, userNo, aContent, aDate) " +
            "VALUES (#{qNo}, #{userNo}, #{qContent}, NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "aNo")
    void insertA(Answer a);
    
    @Select("SELECT i.itemName, u2.userNick AS userNick, " +           
            "q.qTitle, q.qContent, q.qDate, a.aContent, a.aDate " +           
            "FROM question q " +
            "LEFT JOIN answer a ON q.qNo = a.qNo " + 
            "LEFT JOIN item i ON q.itemNo = i.itemNo " +
            "JOIN user u1 ON a.userNo = u1.userNo " + 
            "JOIN user u2 ON q.userNo = u2.userNo " +  
            "WHERE u1.userNo = #{userNo}")
    List<QnA> getAList(int userNo);

    @Update("UPDATE answer SET aContent = #{aContent}, aDate = NOW() WHERE aNo = #{aNo}")
    void updateA(Answer a);

    @Delete("DELETE FROM answer WHERE aNo = #{aNo}")
    void deleteA(int aNo);





}
