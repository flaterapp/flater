const flatSelector = () => {
  document.querySelectorAll(".list-group").forEach((element) => {
  element.addEventListener("click", (event) => {
    console.log("cliked");
  });
});
};

export default flatSelector;
