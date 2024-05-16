package com.ajax.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.ajax.model.dto.Actor;

/**
 * Servlet implementation class JsonSimpleTestServlet
 */
@WebServlet("/json/jsonsimple.do")
public class JsonSimpleTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JsonSimpleTestServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Actor> actors = new ArrayList<>();
		
		actors.add(new Actor("박보검","0104435241","parkBogum.jpg",31,183.2,false));
		actors.add(new Actor("맷대이먼","01011232223","mattDamon.jpg",53,174.2,true));
		actors.add(new Actor("줄리아로버츠","0104435241","juliaRoberts.jpg",58,175.2,true));
		
		// jsonsimple 이용하기
		// JSONObject 객체 이용
		JSONObject jobject = new JSONObject();
		// 각 필드의 값을 put 메소드를 이용해서 JSONObject에 저장
		jobject.put("name", actors.get(0).getName());
		jobject.put("phone", actors.get(0).getPhone());
		jobject.put("profile", actors.get(0).getProfile());
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(jobject); // JSONObject 내부에 있는 toString 으로 ~ 저 객체를 파싱 ~ 
		
		// 다수의 객체를 전송할 때 JSONArray 객체를 이용해서 전송
		JSONArray jarr = new JSONArray();
		// JSONArray에는 JSONObject 객체를 저장
		for(Actor ac : actors) {
			JSONObject o = new JSONObject();
			o.put("name", ac.getName());
			o.put("phone",ac.getPhone());
			o.put("profile", ac.getProfile());
			o.put("age", ac.getAge());
			o.put("height", ac.getHeight());
			o.put("married", ac.isMarried());
			jarr.add(o);
		}
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(jarr);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
