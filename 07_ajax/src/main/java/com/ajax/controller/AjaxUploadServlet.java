package com.ajax.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class AjaxUploadServlet
 */
@WebServlet("/ajax/upload.do")
public class AjaxUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxUploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String path = getServletContext().getRealPath("/upload");
		int maxSize=1024*1024*100;
		String encode="UTF-8";
		MultipartRequest mr = new MultipartRequest(request, path, maxSize, encode, new DefaultFileRenamePolicy());
		
		String name = mr.getParameter("name");
		System.out.println(name);
		Enumeration<String> names = mr.getFileNames();
		List<Map<String,String>> files = new ArrayList();
		while(names.hasMoreElements()) {
			String name1 = names.nextElement();
			String rename = mr.getFilesystemName(name1);
			String oriname = mr.getOriginalFileName(name1);
			files.add(Map.of("rename",rename,"oriname",oriname));
		}
		System.out.println(files);
		
		new Gson().toJson(Map.of("result",true),response.getWriter());
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
