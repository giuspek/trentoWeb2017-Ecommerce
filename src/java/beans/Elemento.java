/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

/**
 *
 * @author Giuseppe
 */
public class Elemento {
    private String name;
    private double price;
    private int quantity, id;
    
    public Elemento(){
        name=null;
        price=0;
        quantity=0;
        id=0;
    }
    
    public int getId(){
        return this.id;
    }
    
    public void setId(int i){
        this.id=i;
    }
    
    public String getName(){
        return this.name;
    }
    
    public void setName(String s){
        this.name=s;
    }
    
    public double getPrice(){
        return this.price;
    }
    
    public void setPrice(double d){
        this.price=d;
    }
    
    public int getQuantity(){
        return this.quantity;
    }
    
    public void setQuantity(int q){
        this.quantity=q;
    }
}
