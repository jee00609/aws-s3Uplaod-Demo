package com.awsTest.s3Upload.exception;

public class InvalidFileSizeException extends Exception {
    public InvalidFileSizeException() {
        super();
    }

    public InvalidFileSizeException(String message) {
        super(message);
    }

    public InvalidFileSizeException(String message, Throwable cause) {
        super(message, cause);
    }

    public InvalidFileSizeException(Throwable cause) {
        super(cause);
    }
}
