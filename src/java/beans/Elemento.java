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
    private String shopName;
    private String shopAddress;
    private int idProduct;
    private String path;
    
    public Elemento(){
        name=null;
        price=0;
        quantity=0;
        id=0;
        shopName=null;
        shopAddress=null;
        idProduct=0;
        path=null;
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
    
    public String getPath(){
        return this.path;
    }
    
    public void setPath(String s){
        this.path=s;
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
    
     public String getShopName(){
        return this.shopName;
    }
    
    public void setShopName(String s){
        this.shopName=s;
    }
     public String getShopAddress(){
        return this.shopAddress;
    }
    
    public void setShopAddress(String s){
        this.shopAddress=s;
    }
    
     public int getIdProduct(){
        return this.idProduct;
    }
    
    public void setIdProduct(int i){
        this.idProduct=i;
    }
}
