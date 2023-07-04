import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "fieldContain"]

  addField(e) {
    e.preventDefault();

    let assoc = e.target.dataset.association;
    let newField = this.buildNewAssociation(assoc);
    this.fieldContainTarget.insertAdjacentHTML("beforeend", newField);
  }

  removeField(e) {
    e.preventDefault();

    let wrapperClass = this.data.get("wrapperClass") || "nested-fields";
    let wrapperField = e.target.closest("." + wrapperClass);
    if(e.target.matches('.dynamic')) {
      wrapperField.remove();
    } else {
      wrapperField.querySelector("input[name*='_destroy']").value = 1;
      wrapperField.style.display = "none";
    }
  }

  buildNewAssociation(assoc) {
    let content  = this.templateTarget.innerHTML;
    let regexpBraced = new RegExp('\\[new_' + assoc + '\\]', 'g');
    let newId  = new Date().getTime();
    let newContent = content.replace(regexpBraced, '[' + newId + ']');

    if (newContent == content) {
      // assoc can be singular or plural 
      regexpBraced = new RegExp('\\[new_' + assoc + 's\\]', 'g');
      newContent = content.replace(regexpBraced, '[' + newId + ']');
    }
    return newContent;
  }
}
