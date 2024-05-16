package com.ajax.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ajax.model.dto.Actor;

/**
 * Servlet implementation class HtmlPageServlet
 */
@WebServlet("/jquery/htmlpage.do")
public class HtmlPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HtmlPageServlet() {
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
		
		request.setAttribute("actors", actors);
		
		request.getRequestDispatcher("/views/actordata.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
