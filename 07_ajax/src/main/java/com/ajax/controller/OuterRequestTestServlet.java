package com.ajax.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class OuterRequestTestServlet
 */
@WebServlet("/dockers")
public class OuterRequestTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OuterRequestTestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 외부요청을 여기애서 보낵 ㅣ!!!
		HttpURLConnection conn = (HttpURLConnection)new URL("https://gdu.co.kr").openConnection();
		try(BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));){ // inputstream 은 바이너리 방식이기 때문에 , InputStreamReader 안애 너어줘서 한글이 안깨지도록 만들어준다.
			
			String data ="";
			StringBuffer sb = new StringBuffer();
			while((data=br.readLine())!=null) {
				sb.append(data);
			}
			response.setContentType("application/json;charset=utf-8");
			response.getWriter().print(sb);
			
		} catch(IOException e) {
			e.printStackTrace();
		}
		conn.disconnect();
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
