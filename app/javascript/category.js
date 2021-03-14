window.addEventListener('load', function(){

  const categoryButton = document.getElementById("category")
  const categoryPulldown = document.getElementById("pull-down")

  categoryButton.addEventListener('click', function() {
    if (categoryPulldown.getAttribute("style") == "display:block;") {
      categoryPulldown.removeAttribute("style", "display:block;")
    } else {
      categoryPulldown.setAttribute("style", "display:block;")
    }  
  })
})