function initPage() {
    let temp = new URLSearchParams(window.location.search).get('id');

    let data;

    data = {'id': temp}


    $.ajax({
        url: "/film/printOne",
        method: "get",
        data: data,
        success: (message) => {
            console.log(message);
            let result = JSON.parse(message);
            console.log(result)
            if (result.status == "success") {
                let data = JSON.parse(result.data);
                console.log("success")
                console.log(data)
                printData(data);
                printReply(temp);

                if (data.role == 0 && data.role == 2) {

                } else if (data.role == 1) {
                    console.log("role 1")
                    let reviewBox = document.getElementById("item-sidebar");
                    // reviewBox.innerHTML = ""
                    let h5 = document.createElement("h5")
                    let button = document.createElement("button")
                    $(button).attr('type', 'button');
                    $(button).addClass("btn btn-primary replyBT")
                    $(button).attr('id', 'replyBT');
                    $(button).attr('data-toggle', 'modal');
                    $(button).attr('data-target', '#review1');

                    $(button).text("입력")
                    $(h5).text("평점을 입력해주세요")
                    $(reviewBox).append(h5)
                    $(reviewBox).append(button)

                } else if (data.role == 3) {
                    console.log("role 3")
                    let reviewBox = document.getElementById("item-sidebar");
                    let button = document.createElement("button")
                    $(button).attr('type', 'button');
                    $(button).addClass("btn btn-primary replyBT")
                    $(button).attr('id', 'replyBT');
                    $(button).attr('data-toggle', 'modal');
                    $(button).attr('data-target', '#review2');
                    // $(button).modal('toggle')

                    $(button).text("입력")
                    $(reviewBox).append(button)
                }
            } else if (result.status == "fail") {
                Swal.fire({title: "!!!!error!!!", text: result.message, icon: "error"}).then(() => {
                    location.href = result.nextPath;
                })
            }
        }
    });


}


function printData(data) {

    $('#film-poster').attr("src", data.poster)
    $('#film-title').text(data.title);
    $('#e-title').text(data.english_title);
    $('#film-summary').text(data.summary);
    $('#filmId').val(data.id);

}

let insertReply = () => {
    let formData = {
        filmId: $('#filmId').val(),
        score: $('#score').val(),
        review: $('#director-name').val()

    }

    console.log("formData : " + formData)
    $.ajax({
        url: "/reply/insert",
        method: "post",
        data: formData,
        success: (message) => {
            let response = JSON.parse(message);
            if (response.status == "fail") {
                console.log("false if 문")
                console.log(response.message)
                Swal.fire({title: response.message, text: "에러 메세지를 확인해주세요", icon: "error"}).then(() => {
                    location.href = response.nextPath;
                })
            } else {
                location.reload();
            }


        }
    })
}


function printReply(filmId) {
    let sendData = {
        "filmId": filmId
    }
    $.ajax({
        url: "/reply/selectAll",
        method: "get",
        data: sendData,
        success: (message) => {
            let response = JSON.parse(message);
            let replyArray = JSON.parse(response.list);

            console.log(replyArray)
            printList(replyArray);
        }
    })
}


function printList(replyArray) {
    var sum = 0;
    var cnt = 0;
    var r_sum = 0;
    var r_cnt = 0;
    if (replyArray.length == 0) {
        $('#film-review-count').text("아직 리뷰가 존재하지 않습니다.")
    } else {
        let box = $(document.getElementById("review-box"))
        replyArray.forEach(reply => {
            if (reply.exist == "true") {
                let div_box = $(document.createElement("div")).addClass("reply_box")
                let div_1 = $(document.createElement("div")).addClass("col-1_5")
                let div_2 = $(document.createElement("div")).addClass("col-10 content")
                let h1 = $(document.createElement("h1"))
                let h4 = $(document.createElement("h4"))
                let p = $(document.createElement("p")).addClass("m-3")
                h1.text(reply.score)
                $(div_1).append(h1)

                h4.text(reply.nickname)
                p.text(reply.review)
                $(div_2).append(h4)
                $(div_2).append(p)
                $(div_box).append(div_1);
                $(div_box).append(div_2);
                $(box).append(div_box);
                r_cnt++
                r_sum = r_sum + reply.score;

            } else if (reply.exist == "false") {
                cnt++
                sum = sum + reply.score
            }

        })
        //별점코드
        if (sum > 0) {
            let avg = sum / cnt
            let star_box = document.getElementById("star_box2")
            let rating_box = document.getElementById("star-rating2")
            let h4 = document.createElement("h4")
            let star_score_1 = document.getElementById("starBox3")
            let h5 = document.createElement("h5")

            let span = document.createElement("span")
            let avgSpan = avg.toPrecision(3) * 20 + "%" //span tag 안에 style 값
            $(span).width(avgSpan)
            $(h4).text(avg.toPrecision(3) + "점 (" + cnt + "개)")
            $(rating_box).append(span)
            $(star_box).append(rating_box)
            $(star_box).append(h4)


            $(h5).html(avg.toPrecision(3) + "점 ");
            $(star_score_1).append(h5)
        }
        if (r_sum > 0) {

            console.log(r_sum)
            console.log(r_cnt)
            let r_avg = r_sum / r_cnt
            console.log("-------"+r_avg.toPrecision(3))
            let star_box = document.getElementById("star_box3")
            let rating_box = document.getElementById("star-rating3")
            let h4 = document.createElement("h4")
            let star_score_2 = document.getElementById("starBox4")
            let h5 = document.createElement("h5")

            let span = document.createElement("span")
            let avgSpan = r_avg.toPrecision(3) * 20 + "%" //span tag 안에 style 값
            $(span).width(avgSpan)
            $(h4).text(r_avg.toPrecision(3) + "점 (" + r_cnt + "개)")
            $(h5).html(r_avg.toPrecision(3) + "점 ")


            $(rating_box).append(span)
            $(star_box).append(rating_box)
            $(star_box).append(h4)

            $(star_score_2).append(h5)

        }
    }

}


