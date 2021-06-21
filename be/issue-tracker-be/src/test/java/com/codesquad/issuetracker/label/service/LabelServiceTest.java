package com.codesquad.issuetracker.label.service;

import com.codesquad.issuetracker.label.controller.LabelDummyData;
import com.codesquad.issuetracker.label.domain.Label;
import com.codesquad.issuetracker.label.domain.Labels;
import com.codesquad.issuetracker.label.dto.LabelRequest;
import com.codesquad.issuetracker.label.dto.LabelResponse;
import com.codesquad.issuetracker.label.dto.LabelResponses;
import com.codesquad.issuetracker.label.repository.LabelRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.mockito.BDDMockito;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import java.util.Optional;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.BDDAssertions.then;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;

@SpringBootTest(classes = {LabelService.class})
class LabelServiceTest {

    @MockBean
    private LabelRepository labelRepository;

    private LabelService labelService;

    @BeforeEach
    void setUp() {
        labelService = new LabelService(labelRepository);
    }
    

    @ParameterizedTest
    @MethodSource("readAllProvider")
    void readAll(Labels given, LabelResponses expected) {
        BDDMockito.given(labelRepository.readAll())
                .willReturn(given);

        LabelResponses actual = labelService.readAll();

        then(actual).isEqualTo(expected);
    }

    @SuppressWarnings("unused")
    static Stream<Arguments> readAllProvider() {
        return Stream.of(
                Arguments.of(
                        Labels.of(
                                Label.builder()
                                        .id(1L)
                                        .name("be")
                                        .description("label for backend")
                                        .color("#1679CF")
                                        .build(),
                                Label.builder()
                                        .id(2L)
                                        .name("fe")
                                        .description("label for frontend")
                                        .color("#3EFC68")
                                        .build()
                        ),
                        LabelDummyData.labelResponses()
                )
        );
    }

    @ParameterizedTest
    @MethodSource("createProvider")
    void create(Label given, LabelResponse expected) {
        LabelRequest givenParameter = LabelRequest.from(given);

        BDDMockito.given(labelRepository.save(givenParameter.toEntity()))
                .willReturn(given);

        LabelResponse actual = labelService.create(givenParameter);

        thenVerifyLabel(actual, expected);
    }

    @SuppressWarnings("unused")
    static Stream<Arguments> createProvider() {
        return Stream.of(
                Arguments.of(
                        Label.builder()
                                .id(1L)
                                .name("be")
                                .description("label for backend")
                                .color("#1679CF")
                                .build(),
                        LabelDummyData.labelResponseBe()
                )
        );
    }

    @ParameterizedTest
    @MethodSource("updateProvider")
    void update(Label given, LabelResponse expected) {
        BDDMockito.given(labelRepository.readById(given.getId()))
                .willReturn(Optional.of(
                        Label.builder()
                                .id(given.getId())
                                .name("name to be updated")
                                .color("#000000")
                                .build()
                ));

        BDDMockito.given(labelRepository.save(given))
                .willReturn(given);

        LabelResponse actual = labelService.update(given.getId(), LabelRequest.from(given));

        thenVerifyLabel(actual, expected);
    }

    @SuppressWarnings("unused")
    static Stream<Arguments> updateProvider() {
        return Stream.of(
                Arguments.of(
                        Label.builder()
                                .id(1L)
                                .name("be")
                                .description("label for backend")
                                .color("#1679CF")
                                .build(),
                        LabelDummyData.labelResponseBe()
                )
        );
    }

    @ParameterizedTest
    @MethodSource("deleteProvider")
    void delete(long given) {
        labelService.delete(given);

        verify(labelRepository, times(1)).deleteById(given);
    }

    @SuppressWarnings("unused")
    static Stream<Arguments> deleteProvider() {
        return Stream.of(
                Arguments.of(
                        1L
                )
        );
    }

    private void thenVerifyLabel(LabelResponse actual, LabelResponse expected) {
        assertThat(actual.getId()).isEqualTo(expected.getId());
        assertThat(actual.getName()).isEqualTo(expected.getName());
        assertThat(actual.getDescription()).isEqualTo(expected.getDescription());
        assertThat(actual.getColor()).isEqualTo(expected.getColor());
    }
}
