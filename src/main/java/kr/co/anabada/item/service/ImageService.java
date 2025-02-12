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
	
	public void saveImage(int itemNo, MultipartFile imageFile) throws Exception {
        if (!imageFile.isEmpty()) {
            byte[] imageBytes = imageFile.getBytes();
            imageMapper.save(itemNo, imageBytes); 
        }
	}
	
	public Integer getImageNo(Image image) {
        return image.getImageNo(); 
    }
}
