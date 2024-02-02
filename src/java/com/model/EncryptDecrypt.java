/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.*;

public class EncryptDecrypt 
{
    public static String encrypt(String strToEncrypt, byte[] key, String cypher) {
	String encryptedString = null;
	try {                  
            Cipher cipher = Cipher.getInstance(cypher);
            final SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            encryptedString = Base64.encodeBase64String(cipher.doFinal(strToEncrypt.getBytes()));
	}
        catch (Exception e) {
            System.err.println(e.getMessage());
	}
	
        return encryptedString;
    }

    public static String decrypt(String codeDecrypt, byte[] key, String cypher){
        String decryptedString = null;
	try {
            Cipher cipher = Cipher.getInstance(cypher);
            final SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            decryptedString = new String(cipher.doFinal(Base64.decodeBase64(codeDecrypt)));
	}
        catch (Exception e) {
            System.err.println(e.getMessage());
	}
	
        return decryptedString;
    }	
}
