package kr.co.anabada.item.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;

import kr.co.anabada.item.entity.Image;

@Mapper
public interface ImageMapper {
	@Insert("INSERT INTO image (itemNo, imageFile) " +
            "VALUES (#{itemNo}, #{imageFile})")
    @Options(useGeneratedKeys = true, keyProperty = "imageNo", keyColumn = "imageNo")
    int save(Image image);

}
