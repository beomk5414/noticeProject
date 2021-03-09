package com.rsupport.notice.command.captcha;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.ui.Model;

public class GetImageCaptchaCommand implements CaptchaCommand {

	@Override
	public Map<String, Object> execute(HttpServletRequest request, Model model) {

		String clientId = "R1WQjCnwwCYjFuADTs4P"; // 애플리케이션 클라이언트 아이디값";
		String clientSecret = "z9A60H57di"; // 애플리케이션 클라이언트 시크릿값";

		// 1) 키 발급 요청하기
		String code = "0"; // 키 발급시 0, 캡차 이미지 비교시 1로 세팅
		String apiURL = "https://openapi.naver.com/v1/captcha/nkey?code=" + code;

		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", clientId);
		requestHeaders.put("X-Naver-Client-Secret", clientSecret);
		String responseBody = get(apiURL, requestHeaders);

		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		try {
			obj = (JSONObject) parser.parse(responseBody);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		// 입력값 비교(InputKeyCheckCommand)에서 캡차 키를 필요로 하므로, session에 올려둔다. session은
		// request에서 알아낸다.
		HttpSession session = request.getSession();
		session.setAttribute("key", (String) obj.get("key"));

		// 2) 캡차 이미지 요청하기
		String key = (String) obj.get("key"); // https://openapi.naver.com/v1/captcha/nkey 호출로 받은 키값
		String apiURL2 = "https://openapi.naver.com/v1/captcha/ncaptcha.bin?key=" + key;

		String filename = get2(request, apiURL2, requestHeaders);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("filename", filename + ".jpg");

		return map;
	}

	// 캡차 키 발급용 get()
	private static String get(String apiUrl, Map<String, String> requestHeaders) {
		HttpURLConnection con = connect(apiUrl);
		try {
			con.setRequestMethod("GET");
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
				return readBody(con.getInputStream());
			} else { // 에러 발생
				return readBody(con.getErrorStream());
			}
		} catch (IOException e) {
			throw new RuntimeException("API 요청과 응답 실패", e);
		} finally {
			con.disconnect();
		}
	}

	private static HttpURLConnection connect(String apiUrl) {
		try {
			URL url = new URL(apiUrl);
			return (HttpURLConnection) url.openConnection();
		} catch (MalformedURLException e) {
			throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
		} catch (IOException e) {
			throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
		}
	}

	private static String readBody(InputStream body) {
		InputStreamReader streamReader = new InputStreamReader(body);

		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder responseBody = new StringBuilder();

			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}

			return responseBody.toString();
		} catch (IOException e) {
			throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
		}
	}

	private static String get2(HttpServletRequest request, String apiUrl, Map<String, String> requestHeaders) {
		HttpURLConnection con = connect(apiUrl);
		try {
			con.setRequestMethod("GET");
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
				return getImage(request, con.getInputStream());
			} else { // 에러 발생
				return error(con.getErrorStream());
			}
		} catch (IOException e) {
			throw new RuntimeException("API 요청과 응답 실패", e);
		} finally {
			con.disconnect();
		}
	}

	private static String getImage(HttpServletRequest request, InputStream is) {
		int read;
		byte[] bytes = new byte[1024];
		// 현재 시간(:timestamp)으로 파일 생성
		String filename = Long.valueOf(new Date().getTime()).toString();

		// 캡차 이미지가 저장될 storage 디렉토리의 경로를 알아낸다.
		String directory = "resources/storage/captcha";

		// request 생성 : execute()에서 request를 받아온다.
		String realPath = request.getServletContext().getRealPath(directory);

		File dir = new File(realPath);

		// TODO 디렉토리에 있는 기존 파일 삭제 기능 필요
		if (dir.exists()) {
			File[] folder_list = dir.listFiles(); // 파일리스트 얻어오기

			for (int j = 0; j < folder_list.length; j++) {
				folder_list[j].delete(); // 파일 삭제
			}

		} else { // dir(storage) 디렉토리가 없으면
			dir.mkdirs(); // 해당 디렉토리(storage 디렉토리)를 생성
		}

		// storage 디렉토리 경로를 포함하도록 File f를 수정
		// File f = new File(filename + ".jpg");
		File f = new File(realPath, filename + ".jpg");
		try (OutputStream outputStream = new FileOutputStream(f)) {
			f.createNewFile();
			while ((read = is.read(bytes)) != -1) {
				outputStream.write(bytes, 0, read);
			}

			return filename;
		} catch (IOException e) {
			throw new RuntimeException("이미지 캡차 파일 생성에 실패 했습니다.", e);
		}
	}

	private static String error(InputStream body) {
		InputStreamReader streamReader = new InputStreamReader(body);

		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder responseBody = new StringBuilder();

			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}

			return responseBody.toString();
		} catch (IOException e) {
			throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
		}
	}

}
