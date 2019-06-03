const flatSelector = () => {
  document.querySelectorAll(".list-group li").forEach((element) => {
  element.addEventListener("click", (event) => {
    console.log("cliked");
    const path = event.currentTarget.dataset.flatId;
    window.location.href = `/flats/${path}`
  });
});
};

export default flatSelector;
