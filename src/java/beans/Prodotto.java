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
public class Prodotto {
    private String name;
    private String description;
    private float price;
    
    public void setName(String s){
        this.name=s;
    }
    
    public String getName(){
        return this.name;
    }
    
    public void setDescription(String s){
        this.description=s;
    }
    
    public String getDescription(){
        return this.description;
    }
    
    public void setPrice(float f){
        this.price=f;
    }
    
    public float getPrice(){
        return this.price;
    }
}
