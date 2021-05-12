defmodule Caterpie.QMSTest do
  use Caterpie.DataCase

  alias Caterpie.QMS

  describe "quizzes" do
    alias Caterpie.QMS.Quiz

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def quiz_fixture(attrs \\ %{}) do
      {:ok, quiz} =
        attrs
        |> Enum.into(@valid_attrs)
        |> QMS.create_quiz()

      quiz
    end

    test "list_quizzes/0 returns all quizzes" do
      quiz = quiz_fixture()
      assert QMS.list_quizzes() == [quiz]
    end

    test "get_quiz!/1 returns the quiz with given id" do
      quiz = quiz_fixture()
      assert QMS.get_quiz!(quiz.id) == quiz
    end

    test "create_quiz/1 with valid data creates a quiz" do
      assert {:ok, %Quiz{} = quiz} = QMS.create_quiz(@valid_attrs)
      assert quiz.description == "some description"
      assert quiz.name == "some name"
    end

    test "create_quiz/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = QMS.create_quiz(@invalid_attrs)
    end

    test "update_quiz/2 with valid data updates the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{} = quiz} = QMS.update_quiz(quiz, @update_attrs)
      assert quiz.description == "some updated description"
      assert quiz.name == "some updated name"
    end

    test "update_quiz/2 with invalid data returns error changeset" do
      quiz = quiz_fixture()
      assert {:error, %Ecto.Changeset{}} = QMS.update_quiz(quiz, @invalid_attrs)
      assert quiz == QMS.get_quiz!(quiz.id)
    end

    test "delete_quiz/1 deletes the quiz" do
      quiz = quiz_fixture()
      assert {:ok, %Quiz{}} = QMS.delete_quiz(quiz)
      assert_raise Ecto.NoResultsError, fn -> QMS.get_quiz!(quiz.id) end
    end

    test "change_quiz/1 returns a quiz changeset" do
      quiz = quiz_fixture()
      assert %Ecto.Changeset{} = QMS.change_quiz(quiz)
    end
  end

  describe "questions_info" do
    alias Caterpie.QMS.QuestionInfo

    @valid_attrs %{response_time: 42, type: 42, value: 42}
    @update_attrs %{response_time: 43, type: 43, value: 43}
    @invalid_attrs %{response_time: nil, type: nil, value: nil}

    def question_info_fixture(attrs \\ %{}) do
      {:ok, question_info} =
        attrs
        |> Enum.into(@valid_attrs)
        |> QMS.create_question_info()

      question_info
    end

    test "list_questions_info/0 returns all questions_info" do
      question_info = question_info_fixture()
      assert QMS.list_questions_info() == [question_info]
    end

    test "get_question_info!/1 returns the question_info with given id" do
      question_info = question_info_fixture()
      assert QMS.get_question_info!(question_info.id) == question_info
    end

    test "create_question_info/1 with valid data creates a question_info" do
      assert {:ok, %QuestionInfo{} = question_info} = QMS.create_question_info(@valid_attrs)
      assert question_info.response_time == 42
      assert question_info.type == 42
      assert question_info.value == 42
    end

    test "create_question_info/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = QMS.create_question_info(@invalid_attrs)
    end

    test "update_question_info/2 with valid data updates the question_info" do
      question_info = question_info_fixture()

      assert {:ok, %QuestionInfo{} = question_info} =
               QMS.update_question_info(question_info, @update_attrs)

      assert question_info.response_time == 43
      assert question_info.type == 43
      assert question_info.value == 43
    end

    test "update_question_info/2 with invalid data returns error changeset" do
      question_info = question_info_fixture()
      assert {:error, %Ecto.Changeset{}} = QMS.update_question_info(question_info, @invalid_attrs)
      assert question_info == QMS.get_question_info!(question_info.id)
    end

    test "delete_question_info/1 deletes the question_info" do
      question_info = question_info_fixture()
      assert {:ok, %QuestionInfo{}} = QMS.delete_question_info(question_info)
      assert_raise Ecto.NoResultsError, fn -> QMS.get_question_info!(question_info.id) end
    end

    test "change_question_info/1 returns a question_info changeset" do
      question_info = question_info_fixture()
      assert %Ecto.Changeset{} = QMS.change_question_info(question_info)
    end
  end

  describe "questions" do
    alias Caterpie.QMS.Question

    @valid_attrs %{is_active: true, text: "some text"}
    @update_attrs %{is_active: false, text: "some updated text"}
    @invalid_attrs %{is_active: nil, text: nil}

    def question_fixture(attrs \\ %{}) do
      {:ok, question} =
        attrs
        |> Enum.into(@valid_attrs)
        |> QMS.create_question()

      question
    end

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert QMS.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert QMS.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      assert {:ok, %Question{} = question} = QMS.create_question(@valid_attrs)
      assert question.is_active == true
      assert question.text == "some text"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = QMS.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      assert {:ok, %Question{} = question} = QMS.update_question(question, @update_attrs)
      assert question.is_active == false
      assert question.text == "some updated text"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = QMS.update_question(question, @invalid_attrs)
      assert question == QMS.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = QMS.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> QMS.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = QMS.change_question(question)
    end
  end
end
