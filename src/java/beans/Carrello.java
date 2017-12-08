/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

import java.util.ArrayList;
import java.util.Iterator;

/**
 *
 * @author Giuseppe
 */
public class Carrello {
    private int number;
    private ArrayList<Elemento> list;
    
    public Carrello(){
        number=0;
        list=new ArrayList<Elemento>();
    }
    
    public ArrayList<Elemento> getList(){
        return list;
    }
    
    public void setList(ArrayList<Elemento> l){
        this.list=l;
    }
    
    public int getNumber(){
        return this.number;
    }
    
    public void addElement(String name, double price, int quantita){
        Elemento e=new Elemento();
        e.setId(number);
        e.setName(name);
        e.setPrice(price);
        e.setQuantity(quantita);
        list.add(e);
        number++;
    }
    
    public void deleteElement(int x){
        list.remove(x);
        number--;
        for(int i=0;i<number;i++){
            list.get(i).setId(i);
        }
        
    }
}
