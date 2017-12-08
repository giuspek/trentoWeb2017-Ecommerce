/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.io.Serializable;

/**
 *
 * @author Giuseppe
 */
public class Utente implements Serializable{
    private int id;
    private String firstName;
    private String lastName;
    private String username;
    private String typeOfAccount;
    private boolean active;
    
    public void setId(int i){
        this.id=i;
    }
    
    public int getId(){
        return this.id;
    }
    
    public void setUsername(String s){
        this.username=s;
    }
    
    public String getUsername(){
        return this.username;
    }
    
    public void setFirstName(String s){
        this.firstName=s;
    }
    
    public String getFirstName(){
        return this.firstName;
    }
    
    public void setLastName(String s){
        this.lastName=s;
    }
    
    public String getLastName(){
        return this.lastName;
    }
    
    public void setTypeOfAccount(String s){
        this.typeOfAccount=s;
    }
    
    public String getTypeOfAccount(){
        return this.typeOfAccount;
    }
    
    public void setActive(boolean x){
        active=x;
    }
    
    public boolean isActive(){
        return this.active;
    }
    
}
