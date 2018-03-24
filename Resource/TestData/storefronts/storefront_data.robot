*** Variables ***
###################### Prepare Data ######################
${prepare_header}               ${CURDIR}/prepare_data/put_data/prepare_header.json
${prepare_menu}                 ${CURDIR}/prepare_data/put_data/prepare_menu.json
${prepare_banner}               ${CURDIR}/prepare_data/put_data/prepare_banner.json
${prepare_content}              ${CURDIR}/prepare_data/put_data/prepare_content.json
${prepare_content_without_type}              ${CURDIR}/prepare_data/put_data/prepare_content_without_type.json
${prepare_content_without_version}              ${CURDIR}/prepare_data/put_data/prepare_content_without_version.json
${prepare_content_without_data}              ${CURDIR}/prepare_data/put_data/prepare_content_without_data.json
${prepare_footer}               ${CURDIR}/prepare_data/put_data/prepare_footer.json
${put_published}                ${CURDIR}/prepare_data/put_data/put_published.json

${prepare_expected_header_raw}          ${CURDIR}/prepare_data/expected_get/expected_header_raw.json
${prepare_expected_menu_raw}            ${CURDIR}/prepare_data/expected_get/expected_menu_raw.json
${prepare_expected_banner}              ${CURDIR}/prepare_data/expected_get/expected_banner.json
${prepare_expected_banner_raw_mode}     ${CURDIR}/prepare_data/expected_get/expected_banner_raw_mode.json
${prepare_expected_content_raw}         ${CURDIR}/prepare_data/expected_get/expected_content_raw.json
${prepare_expected_footer_raw}          ${CURDIR}/prepare_data/expected_get/expected_footer_raw.json

${inactive_menu}                 ${CURDIR}/prepare_data/put_data/inactive_menu.json
${expected_inactive_menu}        ${CURDIR}/prepare_data/expected_get/expected_inactive_menu.json

${updated_content}                  ${CURDIR}/prepare_data/put_data/updated_content.json
${updated_expected_content}         ${CURDIR}/prepare_data/expected_get/expected_content_updated.json

${update_banner_success_01}         ${CURDIR}/banner_data/update_banner_success_01.json
${update_banner_success_02}         ${CURDIR}/banner_data/update_banner_success_02.json
${expected_banner_success_01}         ${CURDIR}/banner_data/expected_banner_success_01.json
${expected_banner_success_02}         ${CURDIR}/banner_data/expected_banner_success_02.json

${update_banner_failed_01}          ${CURDIR}/banner_data/update_banner_failed_01.json
${update_banner_failed_02}          ${CURDIR}/banner_data/update_banner_failed_02.json
${update_banner_failed_03}          ${CURDIR}/banner_data/update_banner_failed_03.json
${update_banner_failed_04}          ${CURDIR}/banner_data/update_banner_failed_04.json
${update_banner_failed_05}          ${CURDIR}/banner_data/update_banner_failed_05.json
${update_banner_failed_06}          ${CURDIR}/banner_data/update_banner_failed_06.json
${update_banner_failed_07}          ${CURDIR}/banner_data/update_banner_failed_07.json

${expected_mix_menu_filter}             ${CURDIR}/expected_mix_menu_filter_web.json
${expected_mix_menu_filter_mobile}      ${CURDIR}/expected_mix_menu_filter_mobile.json

${updated_prepare_header}           ${CURDIR}/shops_data/updated_data/updated_header.json
${updated_prepare_menu}             ${CURDIR}/shops_data/updated_data/updated_menu.json
${updated_prepare_banner}           ${CURDIR}/shops_data/updated_data/updated_banner.json
${updated_prepare_content}          ${CURDIR}/shops_data/updated_data/updated_content.json
${updated_prepare_content_without_type}          ${CURDIR}/shops_data/updated_data/updated_content.json
${updated_prepare_content_without_version}          ${CURDIR}/shops_data/updated_data/updated_content.json
${updated_prepare_content_without_data}          ${CURDIR}/shops_data/updated_data/updated_content.json
${updated_prepare_footer}           ${CURDIR}/shops_data/updated_data/updated_footer.json

${modified_prepare_header}           ${CURDIR}/shops_data/modified_data/modified_header.json
${modified_prepare_menu}             ${CURDIR}/shops_data/modified_data/modified_menu.json
${modified_prepare_banner}           ${CURDIR}/shops_data/modified_data/modified_banner.json
${modified_prepare_content}          ${CURDIR}/shops_data/modified_data/modified_content.json
${modified_prepare_footer}           ${CURDIR}/shops_data/modified_data/modified_footer.json

###################### Incomplete ######################
${incomplete_header}                    ${CURDIR}/incomplete/put_data/incomplete_header.json
${incomplete_menu}                      ${CURDIR}/incomplete/put_data/incomplete_menu.json
${incomplete_inactive_menu}             ${CURDIR}/incomplete/put_data/incomplete_inactive_menu.json
${incomplete_banner}                    ${CURDIR}/incomplete/put_data/incomplete_banner.json
${incomplete_content}                   ${CURDIR}/incomplete/put_data/incomplete_content.json
${incomplete_footer}                    ${CURDIR}/incomplete/put_data/incomplete_footer.json

${expected_header_raw}                          ${CURDIR}/incomplete/expected_get/header_raw.json
${expected_header_name}                         ${CURDIR}/incomplete/expected_get/header_name.json
${expected_header_name_translation}             ${CURDIR}/incomplete/expected_get/header_name_translation.json
${expected_menu_raw}                            ${CURDIR}/incomplete/expected_get/menu_raw.json
${expected_menu_name}                           ${CURDIR}/incomplete/expected_get/menu_name.json
${expected_menu_name_translation}               ${CURDIR}/incomplete/expected_get/menu_name_translation.json
${expected_menu_inactive_raw}                   ${CURDIR}/incomplete/expected_get/menu_inactive_raw.json
${expected_menu_inactive_name}                  ${CURDIR}/incomplete/expected_get/menu_inactive_name.json
${expected_menu_inactive_name_translation}      ${CURDIR}/incomplete/expected_get/menu_inactive_name_translation.json
${expected_banner_raw}                          ${CURDIR}/incomplete/expected_get/banner_raw.json
${expected_banner_name}                         ${CURDIR}/incomplete/expected_get/banner_name.json
${expected_banner_name_translation}             ${CURDIR}/incomplete/expected_get/banner_name_translation.json
${expected_content_raw}                         ${CURDIR}/incomplete/expected_get/content_raw.json
${expected_content_name}                        ${CURDIR}/incomplete/expected_get/content_name.json
${expected_content_name_translation}            ${CURDIR}/incomplete/expected_get/content_name_translation.json
${expected_footer_raw}                          ${CURDIR}/incomplete/expected_get/footer_raw.json
${expected_footer_name}                         ${CURDIR}/incomplete/expected_get/footer_name.json
${expected_footer_name_translation}             ${CURDIR}/incomplete/expected_get/footer_name_translation.json





