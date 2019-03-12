[].forEach.call(document.getElementsByClassName('tags-input'), function (el) {
  let hiddenInput = document.createElement('input'),
    mainInput = document.createElement('input'), tags = [];
  hiddenInput.setAttribute('type', 'hidden');
  hiddenInput.setAttribute('name', 'course[tag]');
  hiddenInput.setAttribute('id', 'course_tag');
  mainInput.setAttribute('type', 'text');
  mainInput.classList.add('form-control');
  mainInput.setAttribute('name', 'course[tag]');
  mainInput.setAttribute('id', 'course_tag');
  mainInput.addEventListener('input', function () {
    let enteredTags = mainInput.value.split(',');
    if (enteredTags.length > 1) {
      enteredTags.forEach(function (t) {
        if (t.length > 0) addTag(t);
      });
      mainInput.value = '';
    }
  });
  mainInput.addEventListener('keydown', function (e) {
    let keyCode = e.which || e.keyCode;
    if (keyCode === 8 && mainInput.value.length === 0 && tags.length > 0) {
      removeTag(tags.length - 1);
    }
  });
  el.appendChild(mainInput);
  el.appendChild(hiddenInput);
  function addTag(text) {
    let tag = {
      text: text, element: document.createElement('span'),
    };
    tag.element.classList.add('tag');
    tag.element.textContent = tag.text;
    let closeBtn = document.createElement('span');
    closeBtn.classList.add('close-sign');
    closeBtn.addEventListener('click', function () {
      removeTag(tags.indexOf(tag));
    });
    tag.element.appendChild(closeBtn);
    tags.push(tag);
    el.insertBefore(tag.element, mainInput);
    refreshTags();
  }
  function removeTag(index) {
    let tag = tags[index];
    tags.splice(index, 1);
    el.removeChild(tag.element);
    refreshTags();
  }
  function refreshTags() {
    let tagsList = [];
    tags.forEach(function (t) {
      tagsList.push(t.text);
    });
    hiddenInput.value = tagsList.join(',');
  }
});
