<%--
  Created by IntelliJ IDEA.
  User: ttyj7
  Date: 2023-02-27
  Time: 오전 10:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>


</head>
<body>

<div class="input-group mb-3 row">

    <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog"
         aria-labelledby="myLargeModalLabel" aria-hidden="true" id="modal_reply">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                </div>
                <h5 style="text-align: center; margin-bottom: 2%"> 평점 입력하기</h5>
                <div class="star-rating space-x-4 mx-auto" id="starBox">
                    <input type="radio" id="5-stars" name="rating" value="5" v-model="ratings"
                           onclick="starValue(this.value)"/>
                    <label for="5-stars" class="star pr-4">★</label>
                    <input type="radio" id="4-stars" name="rating" value="4" v-model="ratings"
                           onclick="starValue(this.value)"/>
                    <label for="4-stars" class="star">★&nbsp &nbsp </label>
                    <input type="radio" id="3-stars" name="rating" value="3" v-model="ratings"
                           onclick="starValue(this.value)"/>
                    <label for="3-stars" class="star">★&nbsp &nbsp </label>
                    <input type="radio" id="2-stars" name="rating" value="2" v-model="ratings"
                           onclick="starValue(this.value)"/>
                    <label for="2-stars" class="star">★&nbsp &nbsp </label>
                    <input type="radio" id="1-star" name="rating" value="1" v-model="ratings"
                           onclick="starValue(this.value)"/>
                    <label for="1-star" class="star">★&nbsp &nbsp </label>
                </div>


                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary"
                            data-dismiss="modal" onclick="insertReply()">입력완료
                    </button>

                </div>
            </div>
        </div>
    </div>
</div>

<!-- Small modal -->

<div class="modal fade bd-example-modal-sm" tabindex="-1" role="dialog"
     aria-labelledby="mySmallModalLabel" aria-hidden="true" id="modal_review2">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">


            <div class="modal-body" id="director_form">
                <div class="form-group">

                </div>
            </div>

        </div>
    </div>
</div>


</div>

<style>
    .star-rating {
        display: flex;
        flex-direction: row-reverse;
        font-size: 2.25rem;
        line-height: 1.8rem;
        justify-content: space-around;
        padding: 0 0.2em;
        text-align: center;
        width: 5em;
    }

    .star-rating input {
        display: none;
    }

    .star-rating label {
        -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
        -webkit-text-stroke-width: 1.5px;
        -webkit-text-stroke-color: #2b2a29;
        cursor: pointer;
    }

    .star-rating :checked ~ label {
        -webkit-text-fill-color: gold;
    }

    .star-rating label:hover,
    .star-rating label:hover ~ label {
        -webkit-text-fill-color: #fff58c;
    }
</style>
<script>
    function starValue(id) {
        console.log(id);
        let hiddenInput = document.createElement("input");
        hiddenInput.type = "hidden";
        hiddenInput.name = "score";
        hiddenInput.id = "score"
        hiddenInput.value = id;
        let starBox = document.getElementById("starBox");
        starBox.appendChild(hiddenInput);

    }

</script>
</body>
</html>
