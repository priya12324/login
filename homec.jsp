package com.login.controller;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController
{
@RequestMapping(value="/")
public ModelAndView front()
{
return new ModelAndView("frontpage");
}
@RequestMapping("/home")
public ModelAndView login(HttpServletRequest req , HttpServletResponse res) throws IOException{
return new ModelAndView("login");
}
   @RequestMapping("/home1")
   public ModelAndView neww() {
   return new ModelAndView("neww");
   }
@RequestMapping(value="/check")
public ModelAndView test(HttpServletResponse response,HttpServletRequest request) throws IOException
{
String username;
String password;
try{
         username = request.getParameter("username");   
         password = request.getParameter("password");
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db","root","1234");    
        PreparedStatement pst = conn.prepareStatement("Select id,pwd from db.logins");
        ResultSet rs = pst.executeQuery(); 
        
        while(rs.next())
        {
        if(rs.getString("id").equals(username))
        return new ModelAndView("alertOfExisting");  
        
        }
pst=conn.prepareStatement("INSERT INTO db.logins(id,pwd)values(?,?)");
pst.setString(1,username);
pst.setString(2,username);
int n=pst.executeUpdate();

     }
   catch(Exception e){       
  System.out.print(e);     
   }
return new ModelAndView("home");
}
@RequestMapping(value="/validate")
public ModelAndView test(HttpServletRequest req , HttpServletResponse res) throws IOException{
try{
      String username = req.getParameter("username");  
      String password = req.getParameter("password");
      Class.forName("com.mysql.jdbc.Driver");  // MySQL database connection
       Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db","root","1234");    
       PreparedStatement pst = conn.prepareStatement("Select id,password from db.logins where id=? and pwd=?");
      pst.setString(1, username);
      pst.setString(2, password);
      ResultSet rs = pst.executeQuery();    
      
      if(rs.next()) {
       return new ModelAndView("welcome");
      }
      
      else {
          return new ModelAndView("home1");
          
      }
 }
 catch(Exception e){      
 System.out.print(e);
 return new ModelAndView("home1");
 }      

}


}
