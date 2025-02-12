package kr.co.anabada.item.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.co.anabada.item.entity.QnA;
import kr.co.anabada.item.entity.Question;


@Mapper
public interface QuestionMapper {
	//문의하기
    @Insert("INSERT INTO question (itemNo, userNo, qTitle, qContent, qDate) " +
            "VALUES (#{itemNo}, #{userNo}, #{qTitle}, #{qContent}, NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "qNo")
    void insertQ(Question q);
    
    //문의 수정
    @Update("UPDATE question SET qTitle = #{qTitle}, qContent = #{qContent} WHERE qNo = #{qNo}")
    void updateQ(Question q);
    
    //문의 삭제
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
    @Select("SELECT i.itemName, q.qTitle, q.qContent, q.qDate, a.aContent, a.aDate " +
            "FROM question q " +
            "LEFT JOIN answer a ON q.qNo = a.qNo " +
            "LEFT JOIN item i ON q.itemNo = i.itemNo " +
            "WHERE q.itemNo = #{itemNo}")
    List<QnA> getQListByItem(int itemNo);

}



    


