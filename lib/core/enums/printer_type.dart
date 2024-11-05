enum PrinterType {
  first("DNP DS620 or Mitsubishi D90 or DNP DS40"),
  second("DNP RX or Mitsubishi CP-M1"),
  third("DNP RX Paper format - 4x6"),
  fourth("DS620 Paper format - 4x6");

  const PrinterType(this.detail);
  final String detail;
}
