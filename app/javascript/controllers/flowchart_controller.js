import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flowchart"
// export default class extends Controller {
//   connect() {
//   }
// }

// 診断フロー全体を 1 つのコントローラで管理する。
// やっていることは「パネル（質問・結果の画面）を 1 枚だけ表示する」だけ。
export default class extends Controller {
  static targets = ["panel", "symptom", "noSymptom", "hint"]

  connect() {
    this.show("qa")
  }

  // 指定した名前のパネルだけを表示し、それ以外は隠す
  show(name) {
    this.panelTargets.forEach((panel) => {
      panel.classList.toggle("hidden", panel.dataset.panel !== name)
    })
    this.hintTarget.classList.add("hidden")
  }

  // 質問B・Cのボタン用。
  // data-flowchart-next-param に書いた名前のパネルへ進む
  choose(event) {
    this.show(event.params.next)
  }

  // 質問Aの「次へ進む」
  next() {
    const hasSymptom = this.symptomTargets.some((box) => box.checked)
    const noSymptom = this.noSymptomTarget.checked

    // 何も選ばれていなければ進まず、案内を出す
    if (!hasSymptom && !noSymptom) {
      this.hintTarget.classList.remove("hidden")
      return
    }

    this.show(hasSymptom ? "result-symptom" : "qb")
  }

  // 「症状なし」を選んだら、他の症状のチェックを外す
  clearSymptoms() {
    if (this.noSymptomTarget.checked) {
      this.symptomTargets.forEach((box) => (box.checked = false))
    }
  }

  // 症状を選んだら、「症状なし」のチェックを外す
  clearNoSymptom() {
    if (this.symptomTargets.some((box) => box.checked)) {
      this.noSymptomTarget.checked = false
    }
  }

  // 結果画面から最初に戻る
  restart() {
    this.symptomTargets.forEach((box) => (box.checked = false))
    this.noSymptomTarget.checked = false
    this.show("qa")
  }
}