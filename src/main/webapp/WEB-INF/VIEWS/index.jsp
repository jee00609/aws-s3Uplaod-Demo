<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/css/bootstrap.min.css">

    <style type="text/css">
        .content {
            margin-top: 50px;
        }

        .title {
            margin-bottom: 50px;
        }

        .copyright {
            margin-top: 100px;
        }
        #progress, #alert, #aws-link  {
            visibility: hidden;
        }
    </style>
    <title>Image Uploader | IT15555854</title>
</head>
<body>
<div id="progress" class="progress">
    <div id="progress-bar" class="progress-bar progress-bar-striped progress-bar-animated"
         role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"
         style="width: 0%"></div>
</div>

<div class="container">
    <div id="alert" class="alert alert-dismissible fade show" role="alert">
        <h5 id="alert-heading" class="alert-heading">Upload Completed!</h5>
        <p id="message"></p>
        <p><a id="aws-link" target="_blank" href="#"></a></p>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="content">
        <div class="row">
            <div class="col-10 offset-1 col-sm-8 offset-sm-2 col-md-6 offset-md-3 align-self-center">
                <h1 class="text-center title">Image Uploader</h1>

                <form method="POST" action="/upload" enctype="multipart/form-data">
                    <div class="input-group mb-3">
                        <input type="file" id="file" name="file" accept="image/*" class="form-control form-control-lg"
                               placeholder="Click to select image to upload"
                               aria-label="Click to select image to upload" aria-describedby="basic-addon2">
                        <div class="input-group-append">
                            <button id="upload" class="btn btn-outline-secondary1 btn-primary btn-lg" type="submit">
                                Upload
                            </button>
                        </div>
                    </div>
                </form>
                <p class="text-right text-muted">Maximum supported image size is 10MB</p>
            </div>
        </div>
    </div>
</div>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="../js/jquery-3.3.1.min.js"></script>
<script src="../js/popper.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script type="application/javascript">
    $(document).ready(function () {
        var file;

        $('input[type=file]').on('change', function (e) {
            file = e.target.files[0];
        });

        $('#upload').on('click', function (e) {
            e.preventDefault();
            var input = $('#file').val();

            if (input == '' || input == undefined) {
                alert("Please select a file to upload.");
            } else {


                var data = new FormData();
                if (file.type.substring(0, 5).toLowerCase() == 'image') {
                    data.append('file', file, file.name);

                    $.ajax({
                        url: '/upload',
                        type: 'POST',
                        data: data,
                        cache: false,
                        dataType: 'json',
                        processData: false,
                        contentType: false,
                        beforeSend: function (xhr) {
                            $('#alert').css('visibility', 'hidden');
                            $('#alert').removeClass('alert-success');
                            $('#alert').removeClass('alert-danger');
                            $('#message').text('');
                            $('#aws-link').text('');
                            $('#aws-link').css('visibility', 'hidden');
                            $('#progress-bar').removeClass('bg-success');
                            $('#progress-bar').css('width', 0 + '%');
                            $('#progress-bar').text('0%');
                            $('#progress-bar').attr('aria-valuenow', 0);
                            $('#progress').css('visibility', 'visible');
                        },
                        success: function (data) {
                            $('#file').val('');
                            $('#progress').css('visibility', 'hidden');
                            $('#alert').css('visibility', 'visible');


                            if(data.success.toLowerCase() == "true" ){
                                $('#alert').addClass('alert-success');
                                $('#alert-heading').text('Upload Completed!');
                                $('#aws-link').text(data.url);
                                $('#aws-link').attr('href', data.url);
                                $('#aws-link').css('visibility', 'visible');
                            }else{
                                $('#alert').addClass('alert-danger');
                                $('#alert-heading').text('Error!');
                                $('#aws-link').css('visibility', 'hidden');

                            }
                            $('#message').text(data.message);
                        },
                        xhr: function () {
                            var xhr = new window.XMLHttpRequest();
                            xhr.upload.addEventListener("progress", function (e) {
                                if (e.lengthComputable) {
                                    var percentComplete = e.loaded / e.total;
                                    percentComplete = parseInt(percentComplete * 100);
                                    $('#progress-bar').text(percentComplete + '%');
                                    $('#progress-bar').css('width', percentComplete + '%');

                                    if (percentComplete == 100) {
                                        setTimeout(function () {
                                            $('#progress-bar').addClass('bg-success');
                                            $('#progress-bar').text('Processing...');
                                        }, 1000);
                                    }
                                }
                            }, false);
                            return xhr;
                        }
                    });
                } else {
                    alert("Please select an image file");
                }
            }
        });
    })
</script>
</body>
</html>