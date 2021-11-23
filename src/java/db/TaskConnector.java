/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import classe.Tarefa;
import java.sql.*;
import java.util.ArrayList;
import web.DantonDbListener;

/**
 *
 * @author danto
 */
public class TaskConnector {
    public static ArrayList<Object> getTasks(String nome) throws Exception{
        ArrayList<Object> list = new ArrayList<>();
        Connection con = DantonDbListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from Danton_tasks where user = '" + nome + "'");
        while(rs.next()){
            Tarefa t = new Tarefa();
            t.setId(rs.getInt("id"));
            t.setTitle(rs.getString("title"));
            list.add(t);
        }
        return list;
    }
    
    public static void addTask(String user, String taskName) throws Exception{
        Connection con = DantonDbListener.getConnection();
        Statement stmt = con.createStatement();
        stmt.execute("insert into Danton_tasks (title, user) values ('" + taskName + "', '"+ user +"')");
        stmt.close();
        con.close();
    }
    
    public static void removeTask(int id) throws Exception{
        Connection con = DantonDbListener.getConnection();
        Statement stmt = con.createStatement();
        stmt.execute("delete from Danton_tasks where id = '" + id + "'");
        stmt.close();
        con.close();
    }
    
} 

