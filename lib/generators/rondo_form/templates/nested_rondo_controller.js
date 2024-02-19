import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "fieldContain"]
  static values = { "fieldClass" : String }

  addField(e) {
    e.preventDefault();

    const newField = this.buildNewAssociation(e);
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

  buildNewAssociation(element) {
    const assoc = element.target.dataset.association;
    const assocs = element.target.dataset.associations;
    const content  = this.templateTarget.innerHTML;
    
    let regexpBraced = new RegExp('\\[new_' + assoc + '\\](.*?\\s)', 'g');
    let newId  = new Date().getTime();
    let newContent = content.replace(regexpBraced, '[' + newId + ']$1');

    if (newContent == content) {
      // assoc can be singular or plural 
      regexpBraced = new RegExp('\\[new_' + assocs + '\\](.*?\\s)', 'g');
      newContent = content.replace(regexpBraced, '[' + newId + ']$1');
    }
    return newContent;
  }
}
