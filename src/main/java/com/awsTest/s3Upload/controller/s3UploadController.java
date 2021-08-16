package com.awsTest.s3Upload.controller;



import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.awsTest.s3Upload.exception.InvalidFileFormatException;
import com.awsTest.s3Upload.exception.InvalidFileSizeException;
import com.awsTest.s3Upload.service.UploadService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
public class s3UploadController {

    @Autowired
    private UploadService uploadService;
    
//    @GetMapping("/")
//	public String index() {
//		return "index";
//	}

    @PostMapping("/upload")
    @ResponseBody
    public Map<String, String> upload(@RequestParam("file") MultipartFile file) {

        Map<String, String> response = new HashMap<>();

        boolean isOperationSuccess = false;
        String message = "";
        String imageUrl = "";

        try{
            imageUrl = uploadService.uploadImage(file);
            message = "Image successfully uploaded.";
            isOperationSuccess = true;
        }catch (IOException e){
            message = "Something wrong with the uploaded file.";
            e.printStackTrace();
        }catch (InvalidFileFormatException e){
            message = "Uploaded file is not an image file.";
            e.printStackTrace();
        }catch (InvalidFileSizeException e){
            message = "Maximum supported image file size is 5MB";
            e.printStackTrace();
        }catch (AmazonServiceException e){
            message = "Something wrong with Amazon S3.";
            e.printStackTrace();
        }catch (SdkClientException e){
            message = "Cannot connect with Amazon S3.";
            e.printStackTrace();
        }


        response.put("success", String.valueOf(isOperationSuccess));
        response.put("message", message);
        response.put("url", imageUrl);

        return response;
    }
}

