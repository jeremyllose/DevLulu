/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

/**
 *
 * @author Cesar
 */
public class UnitCost 
{
    public static float getUnitCost(boolean vat, float transferCost)
    {
        float percent = transferCost * (0.01f * 10.7f);
        float unit = transferCost - percent;
        
        if(vat == true)
        {
            return unit;
        }
        else
        {
            return transferCost;
        }
    }
}
