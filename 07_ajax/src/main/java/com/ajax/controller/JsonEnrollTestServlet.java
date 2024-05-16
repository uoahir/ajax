package com.ajax.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ajax.model.dto.Actor;
import com.google.gson.Gson;

/**
 * Servlet implementation class JsonEnrollTestServlet
 */
@WebServlet("/json/enroll.do")
public class JsonEnrollTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JsonEnrollTestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String data = request.getParameter("data");
		System.out.println(data);
		
		// 아래처럼 매칭시켜서 문자열->객채로 만들어 줄 때 ! json key값과 지정된 클래스의 필드값이 같아야 함 !! 
		Actor a = new Gson().fromJson(data, Actor.class); // 이 전송된 데이터를 액터 클래스랑 매칭시켜라!!!!!
		System.out.println(a.getName());
		System.out.println(a.getAge());
		System.out.println(a.getProfile());
		System.out.println(a.getPhone());
		System.out.println(a.getHeight());
		System.out.println(a.isMarried());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
