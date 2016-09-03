[![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/vknabel/Au3dio/blob/master/LICENSE.md)


# Au3dio

## Layers

| Pipeline          | Module                | Validated/App     |
|-------------------|-----------------------|-------------------|
| `ImportableKey`   | `ParsedImportable`    | `ImportedKey`     |
| `ExportedKey`   	| `ParsedExportable`    | `ExportableKey`   |
| `PipedNode`       | `PipedInjector`       | `ValidatedNode`   |

Die Konfiguration benötigt hierbei allerdings tendenziell die Datenstrukturen für die `Pipeline`, da noch keine Laufzeitinformationen vorhanden sind.

## Todo

- Neues Datenlayout durchsetzen
- `UnparsedKey -> ParsedKey -> TypedKey`
- alle APIs auf die entsprechenden Ebenen auslegen und Konvertierungsfunktionen schreiben (im Idealfall `ImportableKeyConvertable`, `ParsedImportableConvertable`)
- `Au3dio.importers: AnyInjector<ExportedKey> => AnyInjector<ImporterKey>`
- `ParsedImportable` benötigt eine weitere Methode zum Vergleichen, wobei hier der `parameter` ignoriert wird.

# Get in touch

If you have any questions, you can find me on twitter [@vknabel](https://twitter.com/vknabel).
