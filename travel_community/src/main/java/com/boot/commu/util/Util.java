package com.boot.commu.util;

import jakarta.servlet.http.HttpSession;

public class Util {

	public static Boolean checkLogin(HttpSession session) {

		return session.getAttribute("loginUser") == null ? true : false;

	}

}
