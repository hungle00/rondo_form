import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "fieldContain"]
  static values = { "fieldClass" : String }

  addField(e) {
    e.preventDefault();

    let assoc = e.target.dataset.association;
    let newField = this.buildNewAssociation(assoc);
    this.fieldContainTarget.insertAdjacentHTML("beforeend", newField);
  }

  removeField(e) {
    e.preventDefault();
    const wrapperField = this.hasFieldClassValue ? e.target.closest("." + this.fieldClassValue) : e.target.parentNode;
    
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
