### General
1. All files with "_" prefix - not compiles (there are few exceptions) - only imports
2. entry point - styles-m.less (always), styles-l.less (only for - media="screen and (min-width: 768px)" )
3. To override existing variables - _theme.less (needs to copy from parent theme, it will override by fallback)
4. To create new variables - _variables.less
5. Main file that show structure is - _sources.less (you can see that _variables.less - the first in the list so variables will be available in other styles)
```less
@import '_variables.less';
@import '_extends.less';
@import '_typography.less';
@import '_layout.less';
@import '_tables.less';
@import '_messages.less';
@import '_navigation.less';
@import '_tooltips.less';
@import '_loaders.less';
@import '_forms.less';
@import '_icons.less';
@import '_buttons.less';
@import '_sections.less';
@import '_pages.less'; // Theme pager
@import '_actions-toolbar.less';
@import '_breadcrumbs.less';
@import '_popups.less';
@import '_price.less';
```
### Magento import
```less
@import '_styles.less';
//
//  Magento Import instructions
//  ---------------------------------------------

//@magento_import 'source/_module.less'; // Theme modules
//@magento_import 'source/_widgets.less'; // Theme widgets
...
@import 'source/lib/_responsive.less';
//
//  Global variables override
//  ---------------------------------------------
@import 'source/_theme.less';
//
//  Extend for minor customisation
//  ---------------------------------------------

//@magento_import 'source/_extend.less';
```
the //@magento_import 'source/_module.less' - it is M2 custom operator like less @import - but imports all files by mask, not concrete as less @import
there is one bad consequence of this import - it include files and not take into consideration that module can be disabled or even delete, if this file exist - it will be included in import

So by priority:
- source/_module.less - basic module styles that can be extended in custom modules or theme. So if we write our custom module - all styles here (desirably in a theme)
- source/_widgets.less
- source/__extend.less - included at the end. But also can be override by fallback in child theme. Here we write all customizations of vendor modules

### Responsive
```less
.media-width(@extremum, @break) when (@extremum = 'min') and (@break = @screen__l) {
    body {
        background: @desktop_page__background-color;
    }
}

.media-width(@extremum, @break) when (@extremum = 'max') and (@break = @screen__s) {
    body {
        background: @mobile_page__background-color;
    }
}
```
the .media-width it is mixin that will be used in - lib/web/css/source/lib/_responsive.less by according media-query
```less
  @media only screen and (max-width: (@screen__m + 1)) {
    .media-width('max', (@screen__m + 1));
}
```
_entend.less imports last so it can override these media-query by general css, so otr use general in _module.less, or rewrite styles-m.less and styles-l.less
by placing the import of _responsive.less into last place

### Mixin Utils
the `lib/web/css/source/lib/_utilities.less` contain a lot of useful mixin. For example - .lib-visibility-hidden() - to hide some block
```less
 label {
  .lib-visibility-hidden();
  display: block;
}
```
Many these utils also placed into _extend**s**.less
and the same as above but using extends:
```less
   label {
        &:extend(.abs-hidden);
  display: block;
```
or:
```less
    .product-items {
        &:extend(.abs-reset-list all);
    }
```
Big advantage of this method - it will groups all &:extend(.abs-hidden) - into one css instruction, meanwhile direct mixin - leave as is - so many instruction as you uses them