import SwiftUI

private enum Theme {
    static let bg = Color(red: 0.025, green: 0.035, blue: 0.065)
    static let panel = Color(red: 0.065, green: 0.085, blue: 0.125)
    static let panel2 = Color(red: 0.09, green: 0.12, blue: 0.17)
    static let cyan = Color(red: 0.36, green: 0.82, blue: 0.96)
    static let violet = Color(red: 0.61, green: 0.54, blue: 0.98)
    static let muted = Color(red: 0.58, green: 0.65, blue: 0.75)
}

struct NocturneRootView: View {
    @State private var tab = 0
    var body: some View {
        ZStack {
            Theme.bg.ignoresSafeArea()
            VStack(spacing: 0) {
                header
                Group {
                    switch tab {
                    case 0: OverviewScreen()
                    case 1: ResearchScreen()
                    case 2: DeviceScreen()
                    default: AboutScreen()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                bottomBar
            }
        }
        .preferredColorScheme(.dark)
    }

    private var header: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(Theme.panel2).frame(width: 42, height: 42)
                Image(systemName: "moon.stars.fill").font(.system(size: 19)).foregroundStyle(Theme.cyan)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text("NOCTURNE").font(.system(size: 19, weight: .black, design: .rounded)).tracking(2.5)
                Text("IOS RESEARCH CONSOLE").font(.system(size: 8, weight: .bold)).tracking(2).foregroundStyle(Theme.muted)
            }
            Spacer()
            HStack(spacing: 6) {
                Circle().fill(.green).frame(width: 6, height: 6)
                Text("LOCAL").font(.system(size: 9, weight: .bold)).tracking(1).foregroundStyle(Theme.muted)
            }
            .padding(.horizontal, 10).padding(.vertical, 7)
            .background(Theme.panel, in: Capsule())
        }
        .padding(.horizontal, 18).padding(.top, 14).padding(.bottom, 12)
    }

    private var bottomBar: some View {
        HStack(spacing: 0) {
            nav("square.grid.2x2.fill", "Overview", 0)
            nav("doc.text.magnifyingglass", "Research", 1)
            nav("iphone", "Device", 2)
            nav("info.circle", "About", 3)
        }
        .padding(.top, 10).padding(.bottom, 7)
        .background(Theme.panel.opacity(0.98))
    }

    private func nav(_ symbol: String, _ title: String, _ index: Int) -> some View {
        Button { tab = index } label: {
            VStack(spacing: 5) {
                Image(systemName: symbol).font(.system(size: 16, weight: .semibold))
                Text(title).font(.system(size: 9, weight: .semibold))
            }
            .foregroundStyle(tab == index ? Theme.cyan : Theme.muted)
            .frame(maxWidth: .infinity)
        }.buttonStyle(.plain)
    }
}

struct ScreenTitle: View {
    let eyebrow: String
    let title: String
    let subtitle: String
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(eyebrow.uppercased()).font(.system(size: 9, weight: .bold)).tracking(2).foregroundStyle(Theme.cyan)
            Text(title).font(.system(size: 27, weight: .bold, design: .rounded))
            Text(subtitle).font(.system(size: 12)).foregroundStyle(Theme.muted)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct Panel<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        VStack(alignment: .leading, spacing: 11) { content }
            .padding(15).frame(maxWidth: .infinity, alignment: .leading)
            .background(Theme.panel, in: RoundedRectangle(cornerRadius: 16))
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(.white.opacity(0.045), lineWidth: 1))
    }
}

struct OverviewScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 17) {
                ScreenTitle(eyebrow: "Workspace / 01", title: "Research overview", subtitle: "A clean workspace for device notes and vulnerability documentation.")
                HStack(spacing: 10) {
                    statCard("DOSSIERS", "02", "Imported research")
                    statCard("MODULES", "04", "UI components")
                    statCard("MODE", "SAFE", "Documentation")
                }
                Panel {
                    HStack {
                        Label("Active dossier", systemImage: "doc.text.fill").font(.system(size: 13, weight: .semibold))
                        Spacer()
                        Text("IMPORTED").font(.system(size: 8, weight: .bold)).tracking(1).foregroundStyle(Theme.cyan)
                    }
                    Text("CVE-2026-112477").font(.system(size: 20, weight: .bold, design: .rounded))
                    Text("IOSurfaceRoot user-client registry research").font(.system(size: 11)).foregroundStyle(Theme.muted)
                    Divider().overlay(.white.opacity(0.08))
                    HStack {
                        Label("Source archive", systemImage: "archivebox")
                        Spacer()
                        Text("2 dossiers").foregroundStyle(Theme.muted)
                    }.font(.system(size: 11))
                }
                Panel {
                    Label("Workspace modules", systemImage: "square.grid.2x2").font(.system(size: 13, weight: .semibold))
                    moduleRow("Research dossiers", "IOSurfaceRoot and ANE source notes", "doc.text")
                    moduleRow("Device record", "Manual device notes", "iphone")
                    moduleRow("Build pipeline", "GitHub Actions configuration", "hammer")
                }
                Panel {
                    Label("Scope notice", systemImage: "shield.lefthalf.filled").font(.system(size: 13, weight: .semibold))
                    Text("NOCTURNE is a documentation and interface project. It does not execute the supplied proof-of-concept, access kernel memory, or change device security.")
                        .font(.system(size: 11)).foregroundStyle(Theme.muted)
                }
            }.padding(18)
        }
    }

    private func statCard(_ label: String, _ value: String, _ detail: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label).font(.system(size: 8, weight: .bold)).tracking(1.3).foregroundStyle(Theme.muted)
            Text(value).font(.system(size: 19, weight: .bold, design: .rounded)).foregroundStyle(Theme.cyan)
            Text(detail).font(.system(size: 8)).foregroundStyle(Theme.muted).lineLimit(2)
        }.frame(maxWidth: .infinity, alignment: .leading).padding(11)
            .background(Theme.panel2, in: RoundedRectangle(cornerRadius: 13))
    }

    private func moduleRow(_ name: String, _ detail: String, _ icon: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon).foregroundStyle(Theme.cyan).frame(width: 22)
            VStack(alignment: .leading, spacing: 3) {
                Text(name).font(.system(size: 11, weight: .semibold))
                Text(detail).font(.system(size: 9)).foregroundStyle(Theme.muted)
            }
            Spacer()
            Image(systemName: "chevron.right").font(.system(size: 9, weight: .bold)).foregroundStyle(Theme.muted)
        }
    }
}

struct ResearchScreen: View {
    private let facts: [(String, String)] = [
        ("Project label", "CVE-2026-112477 — IOSurfaceRoot User Client Registry UAF."),
        ("Research target", "The archive describes a use-after-free-style condition in the IOSurfaceRoot user-client registry."),
        ("Researcher's reported environment", "The README claims testing on iOS 26.4 (23E246), arm64e. This claim has not been independently verified."),
        ("Reported observation", "The author reports a repeatable stale-entry condition in their test environment. The uploaded materials alone do not establish that the issue affects other devices or OS builds."),
        ("Unresolved questions", "The analysis says the internal entry field layout was not fully mapped and that no kernel write primitive had been attempted."),
        ("Archive completeness", "The README refers to a build.sh file and a src/ path, but neither appears in the uploaded ZIP. The actual Objective-C proof-of-concept file is deliberately not embedded or run by NOCTURNE.")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                ScreenTitle(eyebrow: "Dossier / CVE-2026-112477", title: "IOSurfaceRoot UAF", subtitle: "Source-derived research summary. Claims below are attributed to the uploaded archive.")
                HStack(spacing: 8) {
                    tag("RESEARCH POC", Theme.violet)
                    tag("UNVERIFIED", .orange)
                    tag("DOCS ONLY", Theme.cyan)
                }
                ForEach(facts, id: \.0) { fact in
                    Panel {
                        Text(fact.0.uppercased()).font(.system(size: 8, weight: .bold)).tracking(1.4).foregroundStyle(Theme.cyan)
                        Text(fact.1).font(.system(size: 11)).foregroundStyle(.white.opacity(0.88)).fixedSize(horizontal: false, vertical: true)
                    }
                }
                Panel {
                    Label("Source files", systemImage: "doc.on.doc").font(.system(size: 13, weight: .semibold))
                    Text("README.md · docs/ANALYSIS.md · LICENSE · entry_isurf_uaf.m")
                        .font(.system(size: 10, design: .monospaced)).foregroundStyle(Theme.muted)
                    Text("The source trigger is excluded from this app package. The dossier preserves a high-level record without operational exploit instructions.")
                        .font(.system(size: 10)).foregroundStyle(Theme.muted)
                }
                ScreenTitle(eyebrow: "Dossier / ANE", title: "Apple Neural Engine", subtitle: "A separate research record based on the previously supplied ANE archive summary.")
                HStack(spacing: 8) {
                    tag("SOURCE-REPORTED", .orange)
                    tag("UNVERIFIED", .orange)
                    tag("DOCS ONLY", Theme.cyan)
                }
                Panel {
                    Text("REFERENCED IDENTIFIERS").font(.system(size: 8, weight: .bold)).tracking(1.4).foregroundStyle(Theme.cyan)
                    Text("CVE-2026-84494 · CVE-2026-112696")
                        .font(.system(size: 12, weight: .semibold, design: .monospaced))
                    Text("These identifiers and their association with Apple Neural Engine research were reported in the supplied archive summary. This app does not validate CVE assignment or affected-version claims.")
                        .font(.system(size: 10)).foregroundStyle(Theme.muted)
                }
                Panel {
                    Text("RESEARCH SCOPE").font(.system(size: 8, weight: .bold)).tracking(1.4).foregroundStyle(Theme.cyan)
                    Text("The earlier archive summary described Apple Neural Engine / AppleAVE2 and Core ML-related kernel memory-corruption research. The reported claims have not been independently reproduced or verified here.")
                        .font(.system(size: 11)).foregroundStyle(.white.opacity(0.88))
                    Divider().overlay(.white.opacity(0.08))
                    Text("No trigger code, overflow routine, heap manipulation, kernel-memory operation, or exploit chain is included in this app.")
                        .font(.system(size: 10)).foregroundStyle(Theme.muted)
                }
                Panel {
                    Text("EVIDENCE STATUS").font(.system(size: 8, weight: .bold)).tracking(1.4).foregroundStyle(Theme.cyan)
                    evidenceRow("Archive summary reviewed", "Reported")
                    evidenceRow("CVE assignment independently confirmed", "Not checked")
                    evidenceRow("Affected firmware independently confirmed", "Not checked")
                    evidenceRow("Jailbreak primitive demonstrated", "No evidence")
                }
            }.padding(18)
        }
    }

    private func evidenceRow(_ title: String, _ status: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text(title).font(.system(size: 10)).foregroundStyle(Theme.muted)
            Spacer(minLength: 8)
            Text(status).font(.system(size: 10, weight: .semibold)).foregroundStyle(.white.opacity(0.9))
        }
    }

    private func tag(_ text: String, _ color: Color) -> some View {
        Text(text).font(.system(size: 8, weight: .bold)).tracking(0.8)
            .foregroundStyle(color).padding(.horizontal, 9).padding(.vertical, 6)
            .background(color.opacity(0.12), in: Capsule())
    }
}

struct DeviceScreen: View {
    @State private var model = ""
    @State private var ios = ""
    @State private var chip = ""
    @State private var notes = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ScreenTitle(eyebrow: "Inventory / Manual", title: "Device record", subtitle: "Enter details yourself. NOCTURNE does not inspect the device.")
                input("DEVICE MODEL", placeholder: "e.g. iPhone model", text: $model)
                input("IOS VERSION", placeholder: "e.g. 26.x", text: $ios)
                input("CHIP / ARCHITECTURE", placeholder: "Optional", text: $chip)
                VStack(alignment: .leading, spacing: 7) {
                    Text("NOTES").font(.system(size: 8, weight: .bold)).tracking(1.4).foregroundStyle(Theme.muted)
                    TextEditor(text: $notes).frame(height: 120).scrollContentBackground(.hidden)
                        .padding(8).background(Theme.panel, in: RoundedRectangle(cornerRadius: 12))
                }
                Text("This form is temporary UI state; it does not save or transmit entered information.")
                    .font(.system(size: 10)).foregroundStyle(Theme.muted)
            }.padding(18)
        }
    }

    private func input(_ label: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(label).font(.system(size: 8, weight: .bold)).tracking(1.4).foregroundStyle(Theme.muted)
            TextField(placeholder, text: text).font(.system(size: 12))
                .padding(12).background(Theme.panel, in: RoundedRectangle(cornerRadius: 11))
        }
    }
}

struct AboutScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                ScreenTitle(eyebrow: "Project / About", title: "NOCTURNE", subtitle: "A SwiftUI research interface.")
                Panel {
                    Text("BUILD").font(.system(size: 8, weight: .bold)).tracking(1.4).foregroundStyle(Theme.cyan)
                    Text("NOCTURNE 0.3").font(.system(size: 18, weight: .bold))
                    Text("SwiftUI · iOS 16+ · Documentation-only")
                        .font(.system(size: 10, design: .monospaced)).foregroundStyle(Theme.muted)
                }
                Panel {
                    Label("Included", systemImage: "checkmark.seal").font(.system(size: 13, weight: .semibold))
                    Text("Overview dashboard, two research dossiers, manual device record, project notes, and an unsigned IPA GitHub Actions workflow.")
                        .font(.system(size: 11)).foregroundStyle(Theme.muted)
                }
                Panel {
                    Label("Not included", systemImage: "hand.raised").font(.system(size: 13, weight: .semibold))
                    Text("No exploit trigger, kernel read/write primitive, privilege escalation, persistence, or security bypass.")
                        .font(.system(size: 11)).foregroundStyle(Theme.muted)
                }
            }.padding(18)
        }
    }
}
