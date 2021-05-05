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
end
