package kr.co.anabada.main.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.anabada.main.mapper.SearchMapper;

@Service
public class SearchService {
	@Autowired
	private SearchMapper mapper;
}
