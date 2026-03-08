import UIKit
import SnapKit
import Combine

final class ServerSetupViewController: BaseAuthViewController, UITextFieldDelegate {

    var onComplete: (() -> Void)?

    let vm = ServerSetupViewModel()
    var cancellables = Set<AnyCancellable>()

    let iconWrap    = UIView()
    let iconImg     = UIImageView()
    let titleLabel  = UILabel()
    let subLabel    = UILabel()
    let headerStack = UIStackView()

    let fieldLabel  = UILabel()
    let urlField    = AppTextField(
        placeholder: "http://your-server:8324",
        keyboard: .URL
    )
    let pingButton  = PrimaryButton(
        title: "Test Connection",
        color: AppTheme.Color.accentIndigo
    )
    let pingSpinner = UIActivityIndicatorView(style: .medium)
    let pingStatus  = UILabel()
    let formStack   = UIStackView()

    let continueBtn = PrimaryButton(title: "Continue →")
    let skipLabel   = UILabel()
    let bottomStack = UIStackView()

    private lazy var uiBuilder = ServerSetupViewControllerUIFactory(owner: self)
    private lazy var layoutBuilder = ServerSetupViewControllerLayout(owner: self)

    override var entranceViews: [UIView] {
        [headerStack, formStack]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        urlField.textField.text = vm.urlText
        bindViewModel()
    }

    deinit {
        cancellables.removeAll()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        vm.viewWillDisappear()
    }

    override func setupUI() {
        uiBuilder.buildHeader()
        uiBuilder.buildForm()
        uiBuilder.buildBottom()
    }

    override func setupConstraints() {
        layoutBuilder.setupConstraints()
    }

    private func bindViewModel() {
        vm.$pingState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.applyPingState(state)
            }
            .store(in: &cancellables)
    }

    private func applyPingState(_ state: ServerSetupViewModel.PingState) {
        switch state {
        case .idle:
            pingSpinner.stopAnimating()
            pingButton.isEnabled  = true
            pingStatus.text       = "⚠️  Test the connection first"
            pingStatus.textColor  = AppTheme.Color.textMuted
            resetFieldBorder()
            continueBtn.isEnabled = false
            ScreenAnimator.highlight(continueBtn, enabled: false)

        case .loading:
            pingSpinner.startAnimating()
            pingButton.isEnabled  = false
            pingStatus.text       = "Connecting…"
            pingStatus.textColor  = AppTheme.Color.textSecondary
            continueBtn.isEnabled = false
            ScreenAnimator.highlight(continueBtn, enabled: false)

        case .success(let message):
            pingSpinner.stopAnimating()
            pingButton.isEnabled  = true
            pingStatus.text       = message
            pingStatus.textColor  = AppTheme.Color.success
            setFieldBorder(AppTheme.Color.success.cgColor)
            continueBtn.isEnabled = true
            ScreenAnimator.highlight(continueBtn, enabled: true)

        case .failure(let message):
            pingSpinner.stopAnimating()
            pingButton.isEnabled  = true
            pingStatus.text       = message
            pingStatus.textColor  = AppTheme.Color.error
            setFieldBorder(AppTheme.Color.error.cgColor)
            continueBtn.isEnabled = false
            ScreenAnimator.highlight(continueBtn, enabled: false)
        }
    }

    @objc func urlChanged() {
        vm.urlText = urlField.textField.text ?? ""
        vm.urlDidChange()
    }

    @objc func pingTapped() {
        view.endEditing(true)
        vm.urlText = urlField.textField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        vm.startPing()
    }

    @objc func continueTapped() {
        guard vm.pingPassed else { return }

        ScreenAnimator.pressBounce(continueBtn) { [weak self] in
            self?.vm.saveAndProceed()
            self?.onComplete?()
        }
    }

    @objc func skipTapped() {
        onComplete?()
    }

    func setFieldBorder(_ cgColor: CGColor) {
        UIView.animate(withDuration: 0.22) {
            self.urlField.subviews.first?.layer.borderColor = cgColor
        }
    }

    func resetFieldBorder() {
        UIView.animate(withDuration: 0.20) {
            self.urlField.subviews.first?.layer.borderColor = AppTheme.Color.stroke.cgColor
        }
    }

    func textFieldShouldReturn(_ tf: UITextField) -> Bool {
        tf.resignFirstResponder()
        return true
    }
}
