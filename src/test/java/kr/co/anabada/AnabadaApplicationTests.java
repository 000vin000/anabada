package kr.co.anabada;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import kr.co.anabada.main.mapper.MainMapper;

@SpringBootTest
class AnabadaApplicationTests {
	@Autowired
	private MainMapper mapper;
	
	@Test
	void contextLoads() {

	}

}
