import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['modal']

  connect() {
    this.element.addEventListener('turbo:submit-end', (event) => {
      if (event.detail.success) {
        this.close();
      }
    });
  }

  close() {
    this.modalTarget.close()
  }

  open() {
    this.modalTarget.showModal()
  }
}
