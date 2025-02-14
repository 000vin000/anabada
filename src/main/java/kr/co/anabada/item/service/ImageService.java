package kr.co.anabada.item.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.anabada.item.entity.Image;
import kr.co.anabada.item.mapper.ImageMapper;

@Service
public class ImageService {
	@Autowired
	private ImageMapper imageMapper;
	
	public void saveImage(int itemNo, MultipartFile[] imageFiles) throws Exception {
		 for (MultipartFile imageFile : imageFiles) {
	            if (!imageFile.isEmpty()) {
	                byte[] imageBytes = imageFile.getBytes();
	                imageMapper.save(itemNo, imageBytes); // 각 이미지 데이터를 DB에 저장
	            }
	        }
	    }
	
	public Integer getImageNo(Image image) {
        return image.getImageNo(); 
    }
	
	public void updateImages(int itemNo, MultipartFile[] newImageFiles) throws Exception {
        imageMapper.deleteImagesByItemNo(itemNo);

        // 새로운 이미지를 DB에 저장
        for (MultipartFile imageFile : newImageFiles) {
            if (!imageFile.isEmpty()) {
                byte[] imageBytes = imageFile.getBytes();
                imageMapper.save(itemNo, imageBytes); // 각 이미지 데이터를 DB에 저장
            }
        }
    }
}
