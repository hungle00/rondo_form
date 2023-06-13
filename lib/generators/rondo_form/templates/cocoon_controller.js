import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template"]

  addField(e) {
    e.preventDefault()
    let assoc = e.target.dataset.association
    let newField = this.buildNewAssociation(assoc)
    let insertionNode = this.templateTarget.parentElement
    insertionNode.insertAdjacentHTML("beforebegin", newField)
  }

  removeField(e) {
    e.preventDefault()
    let closestField = e.target.closest(".nested-fields")
    if(e.target.matches('.dynamic')) {
      closestField.remove()
    } else {
      closestField.style.display = "none"
    }
  }

  buildNewAssociation(assoc) {
    let content  = this.templateTarget.innerHTML;
    let regexp_braced = new RegExp('\\[new_' + assoc + '\\]', 'g');
    let new_id  = new Date().getTime();
    let new_content = content.replace(regexp_braced, '[' + new_id + ']');
    if (new_content == content) {
      regexp_braced = new RegExp('\\[new_' + assoc + 's\\]', 'g');
      new_content = content.replace(regexp_braced, '[' + new_id + ']');
    }
    return new_content
  }
}
