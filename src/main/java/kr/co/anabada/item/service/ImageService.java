package kr.co.anabada.item.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.item.entity.Image;
import kr.co.anabada.item.mapper.ImageMapper;

@Service
public class ImageService {
	@Autowired
	private ImageMapper imageMapper;
	
	public void save(Image image) {
		imageMapper.save(image);
	}
	
	public Integer getImageNo(Image image) {
        return image.getImageNo(); 
    }
}
