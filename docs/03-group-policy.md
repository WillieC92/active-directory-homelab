# Group Policy

See `gpo-exports/` for setting tables you can recreate in GPMC.

## Link order (highest precedence last)
1. Default Domain Policy — password / lockout only (keep lean)
2. Baseline - Workstations → Corp\Workstations
3. Baseline - Servers → Corp\Servers
4. Department overrides (rare)

## Golden rules
- Do not overload Default Domain Policy
- One purpose per GPO when possible
- Use security filtering / WMI filters sparingly and document them
- `gpupdate /force` + `gpresult /h report.html` for troubleshooting
